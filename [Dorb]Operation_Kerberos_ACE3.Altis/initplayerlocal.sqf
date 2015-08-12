/*
	Author: Dorbedo
	
	Description:
		initplayerlocal
*/
#include "script_component.hpp"

CHECK(!hasInterface)

waituntil {! isnull player};

/// BIS - Groupmanagement
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;  
["init"] spawn FM(grouptracker);

"DORB_ENDZEIT" addPublicVariableEventHandler {[] spawn FM(disp_timer)};

[] call FM(playeraddaction);
[] call FM(ui_teleport_addaction);
[] call FM(ui_spawn_addaction);
[] call FM(ui_crate_addaction);
[] call FM(ui_teleport_draw3D);
[] call FM(ui_spawn_draw3D);
[] call FM(ui_crate_draw3D);
[] call FM(rescue_draw3D);
[] call FM(addbriefing);
[] call FM(halo_addaction);
call compile preProcessFileLineNumbers "XEH_respawn.sqf";

ISNILS(DORB_MISSION_FNC,[]);
{
	(_x select 0) spawn compile (_x select 1);
}forEach DORB_MISSION_FNC;

[localize "STR_DORB_CLAN",[localize "STR_DORB_WELCOME1",localize "STR_DORB_WELCOME2",localize "STR_DORB_WELCOME3",localize "STR_DORB_WELCOME4",localize "STR_DORB_WELCOME5",localize "STR_DORB_WELCOME6"],"data\logo_brig.paa",false] call FM(disp_info);
[] spawn FM(disp_timer);


[] spawn {
	SCRIPT(PLAYER_DIAG);
	while {true} do {
		[false,false] call FM(debug_performance);
		uisleep 60;
		false
	};

};