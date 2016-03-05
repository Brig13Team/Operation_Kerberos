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

private _newLoc = createLocation ["CBA_NamespaceDummy", _position , _size, _size];
_newLoc setRectangular false;
GVAR(attackpos) pushBack _newLoc;
_newLoc;