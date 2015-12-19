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

GVAR(callIn_airborne) = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"airborne");
GVAR(callIn_airinterception) = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"airinterception");
GVAR(callIn_armored) = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"armored");
GVAR(callIn_cas) = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"cas");
GVAR(callIn_fortifications) = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"fortifications");
GVAR(callIn_motorized) = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"motorized");
GVAR(callIn_drones) = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type)>>"callIn">>"drones");


GVAR(aktive) = true;



