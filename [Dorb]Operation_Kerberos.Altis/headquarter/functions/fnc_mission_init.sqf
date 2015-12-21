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

EGVAR(headquarter,callIn_airinterception) = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type) >> "callIn" >> "airinterception" >> "amount");
EGVAR(headquarter,callIn_cas) = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type) >> "callIn" >> "cas" >> "amount");
EGVAR(headquarter,callIn_motorized) = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type) >> "callIn" >> "motorized" >> "amount");
EGVAR(headquarter,callIn_armored) = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type) >> "callIn" >> "armored" >> "amount");
EGVAR(headquarter,callIn_airborne) = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type) >> "callIn" >> "airborne" >> "amount");
EGVAR(headquarter,callIn_drones) = getNumber(missionconfigfile>>"unitlists">>str GVARMAIN(side)>>GVARMAIN(side_type) >> "callIn" >> "armored" >> "amount");


GVAR(aktive) = true;



