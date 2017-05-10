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
#include "script_component.hpp"

_this params ["_type", "_centerposition", ["_mainOrSide", "main", [""]]];

if !(_mainOrSide in ["main", "side"]) exitWith { -1 };

private _defenceStructure = getText(missionConfigFile >> "mission" >> _mainOrSide >> _type >> "defence" >> "target");
private _amount = [_type] call FUNC(spawn_getAmount);
private _radius = [_type] call FUNC(spawn_getRadius);
private _objects = [];

TRACEV_5(_type,_centerposition,_amount,_radius,_defenceStructure);

private _targetPositions = [];
private _house = false;
switch (_defenceStructure) do {
    case "composition": {
        private _compositionTypes = getArray(missionConfigFile >> "mission" >> _mainOrSide >> _type >> "defence" >> "composition_types");
        private _types = [_type] + _compositionTypes;

        _targetPositions = [_centerposition, _types, _amount, _radius] call EFUNC(spawn,createMissionComposition);
    };
    case "house": {
        _house = true;
        private _houseTypes = getArray(missionConfigFile >> "mission" >> _mainOrSide >> _type >> "defence" >> "house_types");
        private _types = [_type] + _houseTypes;

        _targetPositions = [_centerposition, _types, _amount, _radius] call EFUNC(spawn,createMissionHouse);
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
    } else {
        _target = createVehicle [_class, [0,0,0], [], 0, "CAN_COLLIDE"];
        _target setPosASL _pos;
        _target setVectorUp [0,0,1];
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
