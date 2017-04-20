/*
 *  Author: Dorbedo
 *
 *  Description:
 *      creates a checksum from a value
 *
 *  Parameter(s):
 *      ANY - any input
 *
 *  Returns:
 *      SCALAR - Checksum
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _value = If (IS_STRING(_this)) then {
    _this
} else {
    str _this
};
