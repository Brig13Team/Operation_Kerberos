/*
    Author: Dorbedo

    Description:
        return the attackpos at a Position

    Parameter(s):
        0:ARRAY - Position to check

    Returns:
        Location
*/
#include "script_component.hpp"
_this params [["_position",[10000,10000,10000],[[]],[2,3]]];
private _return = locationNull;
{
    If (_position in _x) exitWith {
        _return = _x;
    };
} forEach (HAS_GET(GVAR(attackpos),"locations"));
_return;
