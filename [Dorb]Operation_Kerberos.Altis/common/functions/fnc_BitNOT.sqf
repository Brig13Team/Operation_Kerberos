/*
 *  Author: Dorbedo
 *
 *  Description:
 *      compares 2 values bitvise
 *
 *  Parameter(s):
 *      0 : SCALAR - Value 1
 *      1 : SCALAR - amount of bits (negativ value results in autodetection (default))
 *
 *  Returns:
 *      SCALAR - the result
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_value1",0,[0]],["_bits",-1,[0]]];

_value1 = abs(_value1);
private _return = 0;

If (_bits < 0) then {
    private _i = 0;
    while {(floor _value1) > 0} do {
        _value1 = (floor _value1) / 2;
        If (_value1 == floor _value1) then {
            _return = _return + 2^_i;
        };
        _i = _i + 1;
    };
}else{
    for "_i" from 0 to _bits do {
        _value1 = (floor _value1) / 2;
        If (_value1 == floor _value1) then {
            _return = _return + 2^_i;
        };
    };
};

_return;
