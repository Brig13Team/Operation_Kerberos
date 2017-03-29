/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the jammerarray for a specific jammer
 *
 *  Parameter(s):
 *      0 : OBJECT - jammer object
 *
 *  Returns:
 *      ARRAY - the jammer array
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
TRACEV_2(_jammer,_ret);
_ret;
