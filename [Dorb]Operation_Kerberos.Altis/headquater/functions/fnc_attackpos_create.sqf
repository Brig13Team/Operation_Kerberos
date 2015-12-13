/*
    Author: Dorbedo
    
    Description:
        revon
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
SCRIPT(attackpos_create);

_this params[["_group",grpNull,[grpNull]]];
private ["_strenght","_position","_logic"];

_strenght = [_group] call FUNC(strenght);

_position = getPos leader _group;

[_position,_strenght] call FUNC(attackpos_create_logic);

true

