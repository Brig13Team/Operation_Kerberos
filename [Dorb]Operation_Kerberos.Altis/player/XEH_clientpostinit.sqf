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