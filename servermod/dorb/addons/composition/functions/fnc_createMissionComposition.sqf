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

private _objectTypes = If (isArray(_cfg >> "ObjectTypes")) then {
    getArray(_cfg >> "ObjectTypes")
} else {
    [getText(_cfg >> "ObjectTypes")]
};
TRACEV_4(_objectTypes,_objectType,_objects,_objects apply {typeOf _x});
_objectTypes pushBack _objectType;
_objectTypes = _objectTypes apply {toLower _x};

private _return = [];
If (_onlyPos) then {
    {
        If ((toLower (typeOf _x)) in _objectTypes) then {
            private _temp = getPosASL _x;
            _temp set[3,getDir _x];
            _return pushBack _temp;
            deleteVehicle _x;
        };
        nil
    } count _objects;
} else {
    _return = _objects select {(toLower (typeOf _x)) in _objectTypes};
};
TRACEV_4(_onlyPos,_return,_objectTypes,_objects);
_return
