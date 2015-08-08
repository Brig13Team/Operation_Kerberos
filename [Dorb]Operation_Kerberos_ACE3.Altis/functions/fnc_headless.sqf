/*
	Author: Dorbedo
	
	Description:
		Headless perframeEH
		
	[{ [] call dorb_fnc_headless } , 30, [] ] call CBA_fnc_addPerFrameHandler;
	
	
*/
#include "script_component.hpp"
SCRIPT(headless);

CHECK(!isMultiplayer)
CHECK((isnil "HC1")&&(isnil "HC2")&&(isnil "HC3"))
ISNILS(DORB_HEADLESS_GROUPS,[]);

private "_groups";
_groups = DORB_HEADLESS_GROUPS;

{
	[_x] call FM(headless_move);
}forEach _groups;

_groups = [];

{
	If ((side _x != DORB_PLAYERSIDE)&&{(groupOwner _x) < 3}) then {
		_groups pushBack _x;
	};
}forEach allGroups;

DORB_HEADLESS_GROUPS = _groups;

