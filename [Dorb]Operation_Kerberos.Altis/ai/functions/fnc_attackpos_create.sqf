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

_strenght = [_group] call FUNC(_strenght);

_position = getPos leader _group;

_logic = "Logic" createVehicle _position;

ISNILS(GVAR(attackpos),[]);

GVAR(attackpos) pushback _logic;

SETVAR(_logic,GVAR(isAttackpos),true);
SETVAR(_logic,GVAR(enemy),_strenght);

true

