/*
 *  Author: Dorbedo
 *
 *  Description:
 *      converts a number into a binary
 *
 *  Parameter(s):
 *      0 : SCALAR - the Number
 *      1 : SCALAR - defined lenght (default: -1) If the desired lenght is smaller then the value is ignored
 *
 *  Returns:
 *      ARRAY - the number as binary
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_number",0,[0]],["_lenght",-1,[0]]];

private _binaryArray = [];
while {floor _number > 0} do {
    _number = (floor _number) / 2;
    _binaryArray pushBack (_number != floor _number);
};

If (_lenght > count _binaryArray) then {
    _binaryArray resize _lenght;
    _binaryArray = _binaryArray apply {if (isNil "_x") then {false}else{_x}};
};

_binaryArray;
