/*
    Author: Dorbedo
    
    Description:
        updates_strength
        do not call directly
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
_this params[["_group",grpNull,[grpNull]]];
if (isNull _group) exitWith {};

([_group] call FUNC(strength_ai)) params ["_type","_value","_threat"];

SETVAR(_group,GVAR(cost),_value);
SETVAR(_group,GVAR(type),_type);
SETVAR(_group,GVAR(threat),_threat);