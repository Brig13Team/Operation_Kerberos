/*
 *  Author: iJesuz, Dorbedo
 *
 *  Description:
 *      prepare target spawning
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *
 *  Returns:
 *      [OBJECT]    - mission targets
 */
#include "script_component.hpp"

_this params ["_mission"];

private _type      = HASH_GET(_mission, "type");
private _position  = HASH_GET(_mission, "location") select 1;
private _defenceStructure = getText(missionConfigFile >> "mission" >> "main" >> _type >> "defence" >> "target");

private _objects = [];
private _amount = [_type] call FUNC(spawn_getAmount);
private _radius = [_type] call FUNC(spawn_getRadius);

private _targetPositions = [];
private _house = false;
switch (_defenceStructure) do {
    case "composition": {
        private _compositionTypes = getArray(missionConfigFile >> "mission" >> "main" >> _type >> "defence" >> "composition_types");
        _type = [_type] + _compositionTypes;

        _targetPositions = [_centerposition, _type, _amount, _radius] call FUNC(createMissionComposition);
    };
    case "house": {
        _house = true;
        private _houseTypes = getArray(missionConfigFile >> "mission" >> "main" >> _type >> "defence" >> "house_types");
        _type = [_type] + _houseTypes;

        _targetPositions = [_centerposition, _type, _amount, _radius] call FUNC(createMissionHouse);
    };
    default {
        _targetPositions = [_position];
    }
};

for "_i" from 1 to _amount do {
    if (_targetPositions isEqualTo []) exitWith { [] };
    private _pos = selectRandom _targetPositions;
    if !(_house) then { _targetPositions = _targetPositions - [_pos]; };

    private _class = selectRandom ([_type] call FUNC(getMissionObject));
    if (isNil "_class") exitWith { [] };

    private "_target";
    if (_class isKindOf "CAManBase") then {
        if (_type isEqualTo "hostage") then {
            _group = createGroup civilian;
        } else {
            _group = createGroup GVARMAIN(side);
        };
        _pos resize 3;

        _target = _group createUnit [_class, _pos, [], 0, "CAN_COLLIDE"];
        _target setPosASL _pos;
    } else {
        _target = createVehicle [_class, _pos, [], 0, "CAN_COLLIDE"];
        _pos set [2, 0];
        _target setPosATL _pos;
        _target setVectorUp [0,0,1];
    };

    if !(isNil QEFUNC(headquarter,registerPOI)) then {
        [_target] call EFUNC(headquarter,registerPOI);
    };
    _objects pushBack _target;
};

_objects
