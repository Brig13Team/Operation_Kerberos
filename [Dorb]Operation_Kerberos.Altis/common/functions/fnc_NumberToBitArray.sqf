/*
 *  Author: Dorbedo
 *
 *  Description:
 *      converts a number into a array of Booleans
 *
 *  Parameter(s):
 *      0 : SCALAR - the Number
 *      1 : SCALAR - defined lenght (default: 32)
 *
 *  Returns:
 *      ARRAY - the number as an array of booleans
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_number",0,[0]],["_lenght",32,[0]]];

If (_lenght < 0) exitWith {[false]};

_number = abs _number;

private _array = [];
for "_i" from 0 to _lenght do {
    _number = (floor _number) / 2;
    _array pushBack (_number != floor _number);
};

_array
