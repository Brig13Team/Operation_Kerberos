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
["init"] call FM(grouptracker);


[] call FM(playeraddaction);
[] call FM(teleport_draw3D);
[] call FM(spawn_ui_draw3D);
[] call FM(crate_draw3D);
[] call FM(rescue_draw3D);
[] call FM(addbriefing);

If (!isMultiplayer) then {
	call compile preProcessFileLineNumbers "XEH_respawn.sqf";
};


[localize "STR_DORB_CLAN",[localize "STR_DORB_WELCOME1",localize "STR_DORB_WELCOME2",localize "STR_DORB_WELCOME3",localize "STR_DORB_WELCOME4",localize "STR_DORB_WELCOME5",localize "STR_DORB_WELCOME6"],"data\logo_brig.paa",false] call FM(disp_info);