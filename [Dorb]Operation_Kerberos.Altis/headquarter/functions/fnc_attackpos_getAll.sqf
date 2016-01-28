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
private _return = [];
{if (_x getVariable[QGVAR(isAttackpos),false]) then {_return pushBack _x;};}forEach (allMissionObjects "Logic");
_return

