/*
	Author: Dorbedo
	
	Description:
		registers Groups to the HQ
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(registerAllGroups);

private["_allGroups"];

_allGroups = allGroups;

{
	if ((!(GETVAR(_x,GVAR(HQ_registered),false)))&&{side _x!= GVARMAIN(playerside) }) then {
		[_x] call FUNC(registerGroup);
	};
}forEach _allGroups;

