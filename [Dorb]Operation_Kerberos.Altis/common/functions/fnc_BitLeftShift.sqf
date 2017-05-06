/*
 *  Author: Dorbedo
 *
 *  Description:
 *      rotates a value bitwise
 *
 *  Parameter(s):
 *      0 : SCALAR - the number to be shifted;
 *      1 : SCALAR - the bit-size of the value
 *      2 : SCALAR - the number of positions the value should be shifted to the left
 *
 *  Returns:
 *      SCALAR - the shifted number
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_value",0,[0]],["_lenght",0,[0]],["_positions",0,[0]]];

_value = abs _value;
// exit if the value is only 1-Bit
If ((_value <= 2)||{_lenght < 2}||{_positions isEqualTo 0}) exitWith {_value};

private _array = [_value] call FUNC(NumberToBitArray);

private _lenght = count _array;
_positions = _positions mod _lenght;

_array = (_array select [_lenght - _positions,_lenght - 1]) + (_array select [0,_lenght - _positions]);

([_array] call FUNC(BitArrayToNumber))
