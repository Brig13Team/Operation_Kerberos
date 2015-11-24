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
TRACEV_1(_type);

GVAR(hq_aktive) = false;

[] call FUNC(reset);

uisleep 15;

SETMVAR(GVAR(HQ_centerpos),_centerposition);

private["_armored","_cas","_motorized","_airborne","_airinterception","_fortifications"];
_airborne = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"airborne");
_airinterception = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"airinterception");
_armored = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"armored");
_cas = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"cas");
_fortifications = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"fortifications");
_motorized = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"motorized");

GVAR(hq_callInArray) = [_airborne,_airinterception,_armored,_cas,_fortifications,_motorized];



GVAR(hq_aktive) = true;



