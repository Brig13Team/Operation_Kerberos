/*
    Author: Dorbedo
    
    Description:
        
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"

_this params[["_group",grpNull,[grpNull]]];

([_group] call FUNC(strength_player)) params ["_type","_value","_threat"];

private _size = (GVAR(definitions) select 1)*1.2;
private _position = getPos leader _group;

If (isNull([_position] call FUNC(attackpos_returnLocAtPos))) exitWith {};

private _newLoc = [_position,_size,false] call EFUNC(common,create_location);

SETVAR(_newLoc,GVAR(type),_type);
SETVAR(_newLoc,GVAR(cost),_value);
SETVAR(_newLoc,GVAR(threat),_threat);
SETVAR(_newLoc,GVAR(troopsSend),0);

GVAR(attackpos) pushBack _newLoc;
_newLoc;