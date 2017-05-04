/*
 *  Author: Dorbedo
 *
 *  Description:
 *      checks if an array has an items which is restriced
 *
 *  Parameter(s):
 *      0 : ARRAY - the array to check
 *
 *  Returns:
 *      BOOL - a resticted item is included
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_array",[],[[]]]];

private _return = false;
{
    If ((IS_STRING(_x))&&{!((toLower _x) in GVAR(curList))}) exitWith {
        _return = true;
    };
    If ((IS_ARRAY(_x))&&{[_x] call FUNC(isRestrictedArray)}) exitWith {
        _return = true;
    };
} forEach _array;
_return;
