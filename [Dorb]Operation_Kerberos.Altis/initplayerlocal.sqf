/*
    Author: Dorbedo
    
    Description:
        initplayerlocal
*/
#include "script_component.hpp"
SCRIPT(initplayerlocal);
CHECK(!hasInterface)

waituntil {! isnull player};

/// BIS - Groupmanagement
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;  
["init"] spawn EFUNC(player,grouptracker);

QEGVAR(mission,endzeit) addPublicVariableEventHandler {[] spawn EFUNC(interface,disp_timer)};
[] spawn EFUNC(interface,disp_timer);


[] call EFUNC(player,playeraddaction);

[] call EFUNC(interface,teleport_init);
[] call EFUNC(interface,spawn_init);
[] call EFUNC(interface,crate_init);

[] call EFUNC(player,addbriefing);
[] call EFUNC(player,halo_addaction);
[] call EFUNC(player,backpack_init);
[] call EFUNC(logistics,init);
[] call EFUNC(player,EH_respawn);

[LSTRING(CLAN),[LSTRING(WELCOME1),LSTRING(WELCOME2),LSTRING(WELCOME3),LSTRING(WELCOME4),LSTRING(WELCOME5),LSTRING(WELCOME6)],"data\logo_brig.paa",false] call EFUNC(interface,disp_info);
