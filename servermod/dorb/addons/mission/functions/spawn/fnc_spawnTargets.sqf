/*
 *  Author: iJesuz, Dorbedo
 *
 *  Description:
 *      prepare target spawning
 *
 *  Parameter(s):
 *      0 : STRING  - type
 *      1 : ARRAY   - position
 *      2 : STRING  - (optional) only "main" or "side"
 *
 *  Returns:
 *      [OBJECT]    - mission targets
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_type", "_centerposition", "_missionCfg"];

private _defenceStructure = getText(_missionCfg >> "objective" >> "target");
private _amount = If (isNumber(_missionCfg >> "objective" >> "amount")) then {
        getNumber(_missionCfg >> "objective" >> "amount");
    }else{
        (getArray(_missionCfg >> "objective" >> "amount")) params ["_min","_max"];
        floor(random(_max - _min) + _min)
    };
private _radius = [_type] call FUNC(spawn_getRadius);
private _objects = [];

TRACEV_5(_type,_centerposition,_amount,_radius,_defenceStructure);

private _newComposition = [false, true] select (getNumber(_missionCfg >> "objective" >> "newComposition"));

If (_newComposition) exitWith {
    private _targets = [];
    switch (_defenceStructure) do {
        case "composition": {
            _targets = [_centerposition, _type, _amount, _radius, false] call EFUNC(composition,spawnObjective);
        };
        case "house": {
            _targets = [_centerposition, _type, _amount, _radius, false] call EFUNC(composition,spawnObjectiveHouse);
        };
    };
    {
        [_x] call EFUNC(headquarter,registerPOI);
    } forEach _targets;
    _targets
};



private _targetPositions = [];
private _house = false;
switch (_defenceStructure) do {
    case "composition": {
        private _compositionTypes = getArray(_missionCfg >> "objective" >> "composition_types");
        private _types = [_type] + _compositionTypes;
        TRACEV_2(_compositionTypes,_types);
        //_targetPositions = [_centerposition, _types, _amount, _radius] call EFUNC(spawn,createMissionComposition);
        _targetPositions = [_centerposition, _type, _amount, _radius, true] call EFUNC(composition,spawnObjective);
    };
    case "house": {
        _house = true;
        private _houseTypes = getArray(_missionCfg >> "objective" >> "house_types");
        private _types = [_type] + _houseTypes;
        TRACEV_2(_houseTypes,_types);
        //_targetPositions = [_centerposition, _types, _amount, _radius] call EFUNC(spawn,createMissionHouse);
        _targetPositions = [_centerposition, _type, _amount, _radius, true] call EFUNC(composition,spawnObjectiveHouse);
    };
};

if (_targetPositions isEqualTo []) then {
    for "_i" from 1 to _amount do {
        private _temp = [_centerposition, 15, _radius] call EFUNC(common,pos_randomFlatEmpty);
        if ((!isNil "_temp")&&{count _temp == 3}) then {
            _targetPositions pushBack (ATLtoASL _temp);
        };
    };
    if (_targetPositions isEqualTo []) then {
        _targetPositions = [ATLtoASL[_centerposition select 0,_centerposition select 1,0]];
    };
};

TRACEV_1(_targetPositions);

for "_i" from 1 to _amount do {
    if (_targetPositions isEqualTo []) exitWith { [] };
    private _pos =+ (selectRandom _targetPositions);
    /* if !(_house) then { */ _targetPositions = _targetPositions - [_pos]; // };
    private _spawnDir = If (count _pos > 3) then {
        _pos select 3;
    }else{
        random 360;
    };
    _pos resize 3;
    private _class = selectRandom ([_type] call FUNC(spawn_getObjects));

    TRACEV_2(_class,_pos);

    if (isNil "_class") exitWith { [] };

    private "_target";
    if (_class isKindOf "CAManBase") then {
        private "_group";
        if (_type isEqualTo "hostage") then {
            _group = createGroup civilian;
        } else {
            _group = createGroup GVARMAIN(side);
        };
        _pos resize 3;

        _target = _group createUnit [_class, [0,0,0], [], 0, "CAN_COLLIDE"];
        _target setPosASL _pos;
        _target setDir _spawnDir;
    } else {
        _target = createVehicle [_class, [0,0,0], [], 0, "CAN_COLLIDE"];
        _target setPosASL _pos;
        _target setVectorUp [0,0,1];
        _target setDir _spawnDir;
    };

    #ifdef DEBUG_MODE_FULL
        [_target,typeof _target,"ColorBlack","hd_dot"] call EFUNC(common,debug_marker_create);
    #endif // DEBUG_MODE_FULL

    if !(isNil QEFUNC(headquarter,registerPOI)) then {
        [_target] call EFUNC(headquarter,registerPOI);
    };
    _objects pushBack _target;
};

_objects
