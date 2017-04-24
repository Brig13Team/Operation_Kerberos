/*
 *  Author: Dorbedo
 *
 *  Description:
 *      rotates an array by positions
 *
 *  Parameter(s):
 *      0 : ARRAY - the array to be shifted;
 *      1 : SCALAR - the number of positions the array should to the left (negativ means right)
 *
 *  Returns:
 *      ARRAY - the shifted array
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_array",[],[[]]],["_positions",0,[0]]];

_array = + _array;

If (_array isEqualTo []) exitWith {_array};

_positions = _positions mod (count _array);
private _lenght = count _array;

If (_positions > 0) then {
    _array = (_array select [_lenght - _positions,_lenght - 1]) + (_array select [0,_lenght - _positions]);
};

If (_positions < 0) then {
    _array = (_array select [_positions,_lenght - 1]) + (_array select [0,_positions]);
};

_array
