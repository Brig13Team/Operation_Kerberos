/**
 * Author: Dorbedo
 * creates a House-Composition in a near House and returns the spawnpositions for MissionObjects
 *
 * Arguments:
 * 0: <ARRAY> the centerposition
 * 1: <SCALAR> radius to search in
 *
 * Return Value:
 * <ARRAY> Array with positions
 *
 */

#include "script_component.hpp"

params [
    "_House",
    "_cfg",
    ["_onlyPos",true,[true]],
    ["_objecttype","Land_CargoBox_V1_F",[""]]
];

private _objects = [_house,_cfg] call FUNC(createHouse);

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
