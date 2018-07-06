#include "script_component.hpp"

/*
  Name: dorb_composition_fnc_createMissionHouse
  Author: Dorbedo
  creates a house composition in a near house and returns the spawnpositions for mission objects

  Arguments:
    0: center position <ARRAY>
    1: search radius <SCALAR>

  Return Value:
    array with positions <ARRAY>

  Public: No
*/

params ["_House", "_cfg", ["_onlyPos", true, [true]], ["_objecttype", "Land_CargoBox_V1_F", [""]]];

private _objects = [_house, _cfg] call FUNC(createHouse);

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
