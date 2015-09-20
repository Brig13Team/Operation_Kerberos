/*
	Author: Dorbedo
	
	Description:
		returns an array with all players
	Parameter(s):
		none
	Return:
		ARRAY - including all players
*/
#include "script_component.hpp"
SCRIPT(players);

If !(isMultiplayer) exitWith {[player]};

[playableUnits, { isPlayer _x }] call BIS_fnc_conditionalSelect;
