/*
 *  Author: Dorbedo
 *
 *  Description:
 *      transfers an array of bits into a number
 *
 *  Parameter(s):
 *      0 : ARRAY - the bin number
 *
 *  Returns:
 *      SCALAR - the Number, -1 on error
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_array",[],[[]]]];

If ((_array isEqualTo [])||{!(_array isEqualTypeAll true)}) exitWith {0};

private _value = 0;
{
    If (_x) then {
        _value = _value + 2^_forEachIndex;
    };
} forEach _array;
_value;
