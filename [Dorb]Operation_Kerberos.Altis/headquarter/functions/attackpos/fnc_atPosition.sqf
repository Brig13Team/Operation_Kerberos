/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the attackposition at given location
 *
 *  Parameter(s):
 *      0 : ARRAY - the postion
 *
 *  Returns:
 *      LOCATION - the location at given position or locationNull
 *
 */
#include "script_component.hpp"

_this params [["_position",[10000,10000,10000],[[]],[2,3]]];
private _return = locationNull;
{
    If (_position in _x) exitWith {
        _return = _x;
    };
} forEach (HASH_GET(GVAR(attackpos),"locations"));
_return;
