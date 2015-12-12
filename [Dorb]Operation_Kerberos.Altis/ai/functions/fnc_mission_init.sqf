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
SCRIPT(init_mission);
_this params[["_centerposition",[],[[]],[2,3]]];

SETMVAR(GVAR(centerpos),_centerposition);

private["_armored","_cas","_motorized","_airborne","_airinterception","_fortifications"];
_airborne = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"airborne");
_airinterception = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"airinterception");
_armored = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"armored");
_cas = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"cas");
_fortifications = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"fortifications");
_motorized = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"motorized");

GVAR(callInArray) = [_airborne,_airinterception,_armored,_cas,_fortifications,_motorized];



GVAR(aktive) = true;



