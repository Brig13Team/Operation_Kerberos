/*
    Author: Dorbedo
    
    Description:
        postinit client
*/
#include "script_component.hpp"

CHECK(!hasInterface)

SETUVAR(EGVAR(interface,respawnTime),nil);

[] call FUNC(addbriefing);
[] call FUNC(halo_addaction);
[] call FUNC(backpack_init);
[] call FUNC(EH_respawn);
[] call FUNC(initKnockKnock);

["init"] spawn FUNC(grouptracker);

waituntil {! isnull player};
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

[
    QEGVAR(interface,message),
    [
        ELSTRING(MAIN,NAME),
        [
            ELSTRING(MAIN,WELCOME1),
            ELSTRING(MAIN,WELCOME2),
            ELSTRING(MAIN,WELCOME3),
            " ",
            ELSTRING(MAIN,AUTHOR),
        ]
    ]
] call CBA_fnc_localEvent;