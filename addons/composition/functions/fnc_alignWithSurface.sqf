#include "script_component.hpp"

/*
  Name: dorb_composition_fnc_alignWithSurface
  Author: Dorbedo
  aligns a composition with the surface

  Arguments:
    0: array with the objects to be alligned <ARRAY>

  Return Value:
    None

  Public: No
*/

params ["_objects"];

_objects = _objects select {vehicle _x == _x};

{
    private _curObj = _x;
    private _objects = lineIntersectsObjs [((getPosASL _curObj) vectorAdd [0,0,200]), ((getPosASL _curObj) vectorAdd [0,0,-20]), objNull, objNull, true, 32];
    _objects = _objects select {!(_x isEqualTo _curObj)};
    If !(_objects isEqualTo []) then {
        private _parent = _objects select 0;
        If !((attachedTo _parent) isEqualTo objNull) then {
            _parent = attachedTo _parent;
        };
        _curObj setVariable [QGVAR(dir), getDirVisual _curObj];
        _curObj setVariable [QGVAR(vecDirAndUp), [vectorDirVisual _curObj, vectorUpVisual _curObj]];
        _curObj attachTo [_parent];
    };
    nil
} count _objects;

{
    private _object = _x;
    If ((attachedTo _object) isEqualTo objNull) then {
        If ((_object isKindOf "HouseBase") || {_object isKindOf "CAManBase"}) then {
            private _pos = getPosWorld _object;
            _pos set [2, getTerrainHeightASL(_pos) + (_pos select 2) - CENTERPOS_OFFSET];
            _object setPosWorld _pos;
        } else {
            private _pos = getPosWorld _object;
            _pos set [2, getTerrainHeightASL(_pos) + (_pos select 2) - CENTERPOS_OFFSET];
            _object setPosWorld _pos;
            private _vecUp = vectorUp _object;
            _vecUp = _vecUp vectorAdd (surfaceNormal _pos);
            _object setVectorUp _vecUp;
        };
    };
    nil
} count _objects;

[
    {
        params ["_objects"];
        {
            If !((attachedTo _x) isEqualTo objNull) then {
                detach _x;
                _x setDir (_x getVariable [QGVAR(dir), getDirVisual _x]);
                _x setVectorDirAndUp (_x getVariable [QGVAR(vecDirAndUp), [vectorDirVisual _x, vectorUpVisual _x]]);
            };
            nil
        } count _objects;
    },
    [_objects],
    1
] call CBA_fnc_waitAndExecute;

