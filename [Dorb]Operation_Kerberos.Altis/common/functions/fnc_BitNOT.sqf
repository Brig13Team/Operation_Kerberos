/*
 *  Author: Dorbedo
 *
 *  Description:
 *      inverts a value bitwise
 *
 *  Parameter(s):
 *      0 : SCALAR - Value
 *      1 : SCALAR - Bit-size
 *
 *  Returns:
 *      SCALAR - the result
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_value",0,[0]],["_bits",24,[0]]];

_value = abs(_value);
private _return = 0;

for "_i" from 0 to _bits do {
    _value = (floor _value) / 2;
    If (_value isEqualTo (floor _value)) then {
        _return = _return + 2^_i;
    };
};

_return
