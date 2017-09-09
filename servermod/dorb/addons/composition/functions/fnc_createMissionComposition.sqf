/**
 * Author: Dorbedo
 * spawns a composition used for missions
 *
 * Arguments:
 * 0: <ARRAY> the centerposition
 * 1: <SCALAR> the direction
 * 2: <BOOL> return only the position (default: true)
 * 3: <STRING> objecttype to be returned (default: Land_CargoBox_V1_F)
 *
 * Return Value:
 * <ARRAY> array with objects or positionASL
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_centerposition", "_cfg", ["_dir", 0, [0]], ["_onlyPos", true, [false]], ["_objecttype", "Land_CargoBox_V1_F", [""]]];

private _objects = [_centerposition, _cfg, _dir] call FUNC(createComposition);

private _objectTypes = If (isText(_cfg >> "ObjectTypes")) then {
    [getText(_cfg >> "ObjectTypes")]
} else {
    getArray(_cfg >> "ObjectTypes")
};
_objectTypes pushBack _objectType;
_objectTypes = _objectTypes apply {toLower _x};

private _return = [];
If (_onlyPos) then {
    {
        If ((toLower (typeOf _x)) in _objectTypes) then {
            _return pushBack (getPosASL _x);
            deleteVehicle _x;
        };
        nil
    } count _objects;
} else {
    _return = _objects select {(toLower (typeOf _x)) in _objectTypes};
};

_return
