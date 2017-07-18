/*
 *  Author: Dorbedo
 *
 *  Description:
 *      return the arithmetic mean of an array of numbers
 *
 *  Parameter(s):
 *      0 : ARRAY - Array with numbers
 *
 *  Returns:
 *      SCALAR - Arithmetic mean
 *
 */
#include "script_component.hpp"

_this params [["_array",[],[[]]]];
If !(_array isEqualTypeAll 0) exitWith {nil};
private _return = 0;
{_return = _return + _x;}forEach _array;
If (_return == 0) exitWith {0};
(_return / (count _array));
