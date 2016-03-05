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

ISNILS(GVAR(attackpos),[]);
private _strenght = [_group] call FUNC(strenght);
private _size = [_group] call FUNC(attackpos_size);
private _position = getPos leader _group;

private _newLoc = [_position,_size,false] call EFUNC(common,create_location);
_newLoc setImportance _strenght;
_newLoc setVariable [QGVAR(troopsNeeded),0];
GVAR(attackpos) pushBack _newLoc;
_newLoc;