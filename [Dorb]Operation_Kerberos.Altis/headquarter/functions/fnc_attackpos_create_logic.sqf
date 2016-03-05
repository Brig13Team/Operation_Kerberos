/*
    Author: Dorbedo
    
    Description:
        
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"

_this params[["_position",[],[[]],[2,3]],["_strenght",0,[0]]];

_logic = "Logic" createVehicleLocal _position;

ISNILS(GVAR(attackpos),[]);

GVAR(attackpos) pushback _logic;

SETVAR(_logic,GVAR(isAttackpos),true);
SETVAR(_logic,GVAR(enemy),_strenght);
SETVAR(_logic,GVAR(strategyID),-1);

true

