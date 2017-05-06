/*
 *  Author: Dorbedo
 *
 *  Description:
 *      inverts a bit-array
 *
 *  Parameter(s):
 *      0 : ARRAY - the bit-array 1
 *      1 : ARRAY - the bit-array 2
 *      2 : SCALAR - force output size of (no forcing by default)
 *
 *  Returns:
 *      SCALAR - the result
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_array1",[],[[]]],["_array2",[],[[]]],["_size",-1,[0]]];

CHECK(!((_array1 isEqualTypeAll true)||(_array2 isEqualTypeAll true)))

private _size = If (_size>0) then {
    _array1 resize _size;
    _array2 resize _size;
    _array1 = _array1 apply {_x isEqualTo true};
    _array2 = _array2 apply {_x isEqualTo true};
    _size
} else {
    (count _array1) min (count _array2)
};

_array1 = + _array1;

for "_i" from 0 to _size do {
    _array1 set []
};

_array = + (If (count _array1<count _array2) then {_array1}else{_array2});

{
    _array set [_forEachIndex,((_array1 select _forEachIndex) || (_array2 select _forEachIndex))];
} forEach _array;


If (_size > 0) then {
    _array1 resize _size;
    _array1 = _array1 apply {if (isNil "_x")then{false}else{_x}};
};
