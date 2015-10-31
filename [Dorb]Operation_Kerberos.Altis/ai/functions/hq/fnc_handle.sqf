/*
	Author: Dorbedo
	
	Description:
		handles AI HQ
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(handle);
CHECK(GETMVAR(GVAR(HQ_working),false))
SETMVAR(GVAR(HQ_working,true));

CHECK((GETMVAR(GVAR(HQ_centerpos),[]) isEqualTo []))



//// remove dead groups
{
	private "_temp";
	_temp = GETMVAR(_x,[]);
	_temp = _temp - grpNull;
	SETMVAR(_x,_temp);
} forEach [GVAR(HQ_Other),GVAR(HQ_marine),GVAR(HQ_Car),
			GVAR(HQ_Drone),GVAR(HQ_Tank),GVAR(HQ_Infanterie),
			GVAR(HQ_Attack_Helicopter),GVAR(HQ_Transport_Helicopter),
			GVAR(HQ_CAS_Plane),GVAR(HQ_Air_other)];



//// Gather Informations -> where does the enemy attack
private["_attackpositions","_attackarray"];
_attackarray = [QGVAR(hq_dangerzones)] call EFUNC(common,matrix_find_peaks);
_attackpositions = [];
{
	_attackpositions pushBack [
							((GVAR(HQ_centerpos) select 0)-(GVAR(hq_definitions) select 0) + ((_x select 1)*(GVAR(hq_definitions) select 1))),
							((GVAR(HQ_centerpos) select 1)+(GVAR(hq_definitions) select 1) - ((_x select 2)*(GVAR(hq_definitions) select 1))),
							0
							];
}forEach _attackarray;

// Check Radars
_aircontacts = [] call FUNC(hq_check_radars);
// Check Spotters
_spotter_requests = [] call FUNC(hq_check_spotter);
// Check Requests
_support_requests = GETMVAR(GVAR(hq_support_requests),[]);
SETMVAR(GVAR(hq_support_requests),[]);


//// Check for availlaible Squads in Range




///// Make decisions




//// Call Support (Call-In Units or Off-Map Support)




SETMVAR(GVAR(HQ_working),false);

