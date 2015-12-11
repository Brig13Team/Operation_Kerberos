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
SCRIPT(attackpos_create_logic);

_this params[["_position",[],[[]],[2,3]],["_strenght",0,[0]];

_logic = "Logic" createVehicleLocal _position;

ISNILS(GVAR(attackpos),[]);

GVAR(attackpos) pushback _logic;

SETVAR(_logic,GVAR(isAttackpos),true);
SETVAR(_logic,GVAR(enemy),_strenght);

true

