/**
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the distance coeffizient
 *      used to raise the value if the enemys are near
 *
 *  Parameter(s):
 *      0 : ARRAY - Position
 *
 *  Returns:
 *      SCALAR - distance factor
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params ["_position"];

#define MAXIMUM 2

_position = [_position] call CBA_fnc_getPos;

private _coeff = 1;

{
    private _poiLoc = _x;
    If (_position in _poiLoc) exitWith {
        _coeff = MAXIMUM;
    };
    private _distance = (_position distance2D (getPos _poiLoc)) max 100;
    _coeff = _coeff max (3*(log _distance / log 0.00001)+3);
} forEach HASH_GET_DEF(GVAR(POI),"locations",[]);

((_coeff max 1) min MAXIMUM);
