/*
	Author: Dorbedo
	
	Description:
		List the players
		CBA doesn't ignore HC -> Workaround for my Mission
	
	Return
	ARRAY
*/
#include "makros.hpp"
//SCRIPT(players);

private "_return";

_return = if (isMultiplayer) then {
	[playableUnits, { (isPlayer _x) && (!(_x in [HC1,HC2,HC3])) }] call BIS_fnc_conditionalSelect;
} else {
	[player];
};

_return;
