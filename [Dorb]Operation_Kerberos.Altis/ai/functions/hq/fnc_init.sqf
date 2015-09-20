/*
	Author: Dorbedo
	
	Description:
		initialiuzes AI HQ
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(init);
#define INTERVALL_HQ 30


GVAR(hq_aktive) = true;



[
	{
		_this call FUNC(hq_handle);
	},
	INTERVALL_HQ,
	[]
] call CBA_fnc_addPerFrameHandler;
