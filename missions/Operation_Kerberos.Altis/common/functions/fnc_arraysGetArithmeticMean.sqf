/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the arithmetic mean of a array of arrays
 *
 *  Parameter(s):
 *      0 : ARRAY - Array of arrays
 *
 *  Returns:
 *      ARRAY - Array of arithmetic mean
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_array",[],[[]]]];
CHECK(_array isEqualTo [])
_array =+ _array;

private _size = count _array;

private _return = _array deleteAt 0;
If (_size == 1) exitWith {_return};

{
    private _curArray = _x;
    {
        _return set [_forEachIndex,(_return select _forEachIndex) + _x];
    } forEach _curArray;
    nil;
} count _array;

_return apply {_x/_size};
