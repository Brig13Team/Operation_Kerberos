/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_jammer"];

private _ret = [];

{
    If (_jammer == (_x select 0)) exitWith {
        _ret = _x;
    };
} forEach GVAR(jammer);

_ret;
