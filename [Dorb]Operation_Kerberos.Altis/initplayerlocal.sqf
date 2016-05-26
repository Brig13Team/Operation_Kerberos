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

[] call EFUNC(player,playeraddaction);
[] call EFUNC(interface,teleport_addaction);
[] call EFUNC(interface,spawn_addaction);
[] call EFUNC(interface,crate_addaction);
[] call EFUNC(interface,teleport_draw3D);
[] call EFUNC(interface,spawn_draw3D);
[] call EFUNC(interface,crate_draw3D);
[] call EFUNC(mission,rescue_draw3D);
[] call EFUNC(player,addbriefing);
[] call EFUNC(player,halo_addaction);
[] call EFUNC(player,backpack_init);
[] call EFUNC(interface,hud_init);
[] call EFUNC(player,XEH_respawn);

ISNILS(EGVAR(mission,fnc),[]);
{
	(_x select 0) spawn compile (_x select 1);
}forEach EGVAR(mission,fnc);

[LSTRING(CLAN),[LSTRING(WELCOME1),LSTRING(WELCOME2),LSTRING(WELCOME3),LSTRING(WELCOME4),LSTRING(WELCOME5),LSTRING(WELCOME6)],"data\logo_brig.paa",false] call EFUNC(interface,disp_info);
[] spawn EFUNC(interface,disp_timer);
/*
[] spawn {
	SCRIPTIN(initplayerlocal,performance);
	while {true} do {
		[false,false] call FUNC(debug_performance);
		uisleep 60;
		false
	};
};*/