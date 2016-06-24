/*
    Author: Dorbedo
    
    Description:
        return an attackpos
    
    Parameter(s):
        0:ARRAY - Position to check

    Returns:
        Location
*/
#include "script_component.hpp"
_this params [["_position",[],[[]],[2,3]]];
private _return = locationNull;
{
    If (_position in _x) exitWith {
        _return = _x;
    };
} forEach GVAR(attackpos);
_return;