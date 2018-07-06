#include "script_component.hpp"

/*
  Name: dorb_composition_fnc_createMissionComposition
  Author: Dorbedo
  spawns a composition used for missions

  Arguments:
    0: position of center <ARRAY>
    1: direction of the center <SCALAR>
    2: return only the position <BOOL> (default: true)
    3: objecttype to be returned <STRING> (default: Land_CargoBox_V1_F)

  Return Value:
    array with objects or positionASL <ARRAY>

  Public: No
*/

params ["_centerposition", "_cfg", ["_dir", 0, [0]], ["_onlyPos", true, [false]], ["_objecttype", "Land_CargoBox_V1_F", [""]]];

private _objects = [_centerposition, _cfg, _dir] call FUNC(createComposition);

private _objectTypes = If (isArray(_cfg >> "ObjectTypes")) then {
    getArray(_cfg >> "ObjectTypes")
} else {
    [getText(_cfg >> "ObjectTypes")]
};

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
    } forEach _objects;
} else {
    _return = _objects select {(toLower (typeOf _x)) in _objectTypes};
};

_return
