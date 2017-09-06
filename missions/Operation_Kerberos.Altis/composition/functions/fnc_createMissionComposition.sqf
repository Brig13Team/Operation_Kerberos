/**
 * Author: Dorbedo
 * spawns a composition used for missions
 *
 * Arguments:
 * 0: <ARRAY> the centerposition
 * 1: <SCALAR> the direction
 * 2: <STRING> objecttype to be returned (default: Land_CargoBox_V1_F)
 * 3: <BOOL> return only the position (default: true)
 *
 * Return Value:
 * <ARRAY> array with objects or positionASL
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_centerposition",["_dir",0,[0]],["_objecttype","Land_CargoBox_V1_F",[""]],["_onlyPos",true,[false]]];

private _configs = [_objecttype] call FUNC(getPossibleMissionComposition);
private _cfg = selectRandom(_configs);

private _objects = [_centerposition, _dir, _cfg] call FUNC(createComposition);

private _return = [];
If (_onlyPos) then {
    {
        If (_x isKindOf _objectType) then {
            _return pushBack (getPosASL _x);
            deleteVehicle _x;
        };
        nil
    } count _objects;
} else {
    _return = _objects select {_x isKindOf _objectType};
};

_return
