/*
	Author: Dorbedo
	
	Description:
		initplayerlocal
*/
#include "makros.hpp"

CHECK(!hasInterface)

waituntil {! isnull player};

//player addEventHandler ["Killed", {[_this] call FM(onKilled);}];	
//player addEventHandler ["Respawn", {[_this] call FM(afterplayerrespawn);}];
//player addEventHandler ["Fired", {_this call FM(firedbase);}];		
//player addEventHandler ["Hit", {_this call FM(hittk);}];			

/// BIS - Groupmanagement
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;  

[] call FM(afterplayerrespawn);
[] call FM(playeraddaction);
[] call FM(teleport_draw3D);
[] call FM(spawn_ui_draw3D);
[] call FM(crate_draw3D);
[] call FM(rescue_draw3D);
[] call FM(addbriefing);


[localize "STR_DORB_CLAN",[localize "STR_DORB_WELCOME1",localize "STR_DORB_WELCOME2",localize "STR_DORB_WELCOME3",localize "STR_DORB_WELCOME4",localize "STR_DORB_WELCOME5",localize "STR_DORB_WELCOME6"],"data\logo_brig.paa",false] call FM(disp_info);