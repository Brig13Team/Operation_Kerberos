/**
 *  Author: Dorbedo
 *
 *  Description:
 *      gets the sum of an array
 *
 *  Parameter(s):
 *      0 : ARRAY - the array
 *
 *  Returns:
 *      SCALAR - the sum
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_array",[],[[]]]];

If ((_array isEqualTo [])||{!(_array isEqualTypeAll 0)}) exitWith {nil};

private _return = _array deleteAt 0;
{
    _return = _return + _x;
    nil;
} count _array;
_return;
