/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the key to a value
 *
 *  Parameter(s):
 *      0 : LOCATION - the hash
 *      1 : ANY - the value
 *
 *  Returns:
 *      STRING - the key of a value, empty string, if not availible
 *
 */
#include "script_component.hpp"

_this params ["_hash","_value"];

If !(IS_HASH(_hash)) exitWith {""};

private _return = "";

{
    If ((HASH_HASKEY(_hash,_x))&&{HASH_GET(_hash,_x) isEqualTo _value}) exitWith {_return = _x;};
} count (allVariables _hash);

_return;
