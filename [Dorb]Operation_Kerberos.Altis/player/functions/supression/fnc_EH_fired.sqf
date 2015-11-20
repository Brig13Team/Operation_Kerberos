/*
	Author: Dorbedo
	
	Description:
		supression fired EH
	
	Parameter(s):
	

	Return
		none
*/
#include "script_component.hpp"
SCRIPT(EH_fired);
_this params ["_unit","_weapon","_muzzle","_mode","_ammo","_magazine",["_projectile",objNull,[objNull]]];
CHECK(((_unit distance player)>2000)||((side effectiveCommander (vehicle _unit)) == playerside))
CHECK((_weapon in ["_throw","_put"])||(isNull _projectile))

private "_hit";
_hit = getNumber(configfile>>"CfgAmmo">>_ammo>>"_hit");
CHECK(_hit == 0)

[{_this call FUNC(supression_handle_fired)}, 0, [_projectile, _hit] ] call CBA_fnc_addPerFrameHandler;	