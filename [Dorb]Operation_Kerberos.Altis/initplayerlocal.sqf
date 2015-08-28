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
[] call EFUNC(logistics,init);
[] call EFUNC(interface,hud_init);
[] call EFUNC(player,XEH_respawn);

ISNILS(EGVAR(mission,fnc),[]);
{
	(_x select 0) spawn compile (_x select 1);
}forEach EGVAR(mission,fnc);

["STR_DORB_CLAN",["STR_DORB_WELCOME1","STR_DORB_WELCOME2","STR_DORB_WELCOME3","STR_DORB_WELCOME4","STR_DORB_WELCOME5","STR_DORB_WELCOME6"],"data\logo_brig.paa",false] call EFUNC(interface,disp_info);
[] spawn EFUNC(interface,disp_timer);
/*
[] spawn {
	SCRIPT(PLAYER_DIAG);
	while {true} do {
		[false,false] call FUNC(debug_performance);
		uisleep 60;
		false
	};
};*/