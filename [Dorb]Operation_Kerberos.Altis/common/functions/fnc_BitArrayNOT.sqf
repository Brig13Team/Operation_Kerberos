/*
 *  Author: Dorbedo
 *
 *  Description:
 *      inverts a bit-array
 *
 *  Parameter(s):
 *      0 : ARRAY - the bit-array
 *
 *  Returns:
 *      SCALAR - the result
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_array",[],[[]]],["_size",32,[0]]];

CHECK(!(_array isEqualTypeAll true))

If !((count _array) isEqualTo _size) then {
    _array resize _size;
};

_array apply {!(_x isEqualTo true)}
