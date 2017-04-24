/*
 *  Author: Dorbedo
 *
 *  Description:
 *      compares 2 values bitvise, supports HEX values
 *
 *  Parameter(s):
 *      0 : SCALAR - Value 1
 *      1 : SCALAR - Value 2
 *
 *  Returns:
 *      SCALAR - the result
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_value1",0,[0]],["_value2",0,[0]]];

_value1 = abs(_value1);
_value2 = abs(_value2);

private _return = 0;
private _i = 0;
while {((floor _value1) > 0) && ((floor _value2) > 0)} do {
    _value1 = (floor _value1) / 2;
    _value2 = (floor _value2) / 2;
    If ((_value1 != floor _value1)&&(_value2 != floor _value2)) then {
        _return = _return + 2^_i;
    };
    _i = _i + 1;
};
_return;
