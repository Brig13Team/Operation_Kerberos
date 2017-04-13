/**
 *  Author: Dorbedo
 *
 *  Description:
 *      compares array with values and returns the max of each arraypos
 *
 *  Parameter(s):
 *      0 : ARRAY - Array of arrays
 *
 *  Returns:
 *      ARRAY - array with max
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_array",[],[[]]]];

_array =+ _array;

private _return = _array deleteAt 0;
{
    {
        _return set [_forEachIndex,(_return select _forEachIndex) max _x];
    } forEach _x;
    nil;
} count _array;
_return;
