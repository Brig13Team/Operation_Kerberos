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
#define INTERVALL_HQ_GROUPS 300

GVAR(hq_aktive) = true;

ISNILS(GVAR(HQ_Area_killed,[]));



[
	{
		_this call FUNC(hq_handle);
	},
	INTERVALL_HQ,
	[]
] call CBA_fnc_addPerFrameHandler;

[
	{
		{
			private "_temp";
			_temp = GETMVAR(_x,[]);
			_temp = _temp - grpNull;
			SETMVAR(_x,_temp);
		} forEach [GVAR(HQ_Other),GVAR(HQ_marine),GVAR(HQ_Car),
			GVAR(HQ_Drone),GVAR(HQ_Tank),GVAR(HQ_Infanterie),
			GVAR(HQ_Attack_Helicopter),GVAR(HQ_Transport_Helicopter),
			GVAR(HQ_CAS_Plane),GVAR(HQ_Air_other)];
		[] call FUNC(hq_registerAllGroups);
	},
	INTERVALL_HQ_GROUPS,
	[]
] call CBA_fnc_addPerFrameHandler;




