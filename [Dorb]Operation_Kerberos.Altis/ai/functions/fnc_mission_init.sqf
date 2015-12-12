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

private _airborne = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"airborne");
private _airinterception = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"airinterception");
private _armored = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"armored");
private _cas = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"cas");
private _fortifications = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"fortifications");
private _motorized = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"motorized");
private _drones = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"drones");

GVAR(callInArray) = [_airborne,_airinterception,_armored,_cas,_fortifications,_motorized,_drones];



GVAR(aktive) = true;



