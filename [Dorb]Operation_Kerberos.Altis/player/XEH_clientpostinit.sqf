/*
    Author: Dorbedo
    
    Description:
        postinit client
*/
#include "script_component.hpp"

CHECK(!hasInterface)

SETUVAR(EGVAR(interface,respawnTime),nil);

[] call FUNC(playeraddaction);
[] call FUNC(addbriefing);
[] call FUNC(halo_addaction);
[] call FUNC(backpack_init);
[] call FUNC(EH_respawn);
[] call FUNC(initKnockKnock);

["init"] spawn FUNC(grouptracker);

waituntil {! isnull player};
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
[
    LSTRING(CLAN),
    [LSTRING(WELCOME1),LSTRING(WELCOME2),LSTRING(WELCOME3),LSTRING(WELCOME4),LSTRING(WELCOME5),LSTRING(WELCOME6)],
    "data\logo_brig.paa",
    false
] call EFUNC(interface,disp_info);