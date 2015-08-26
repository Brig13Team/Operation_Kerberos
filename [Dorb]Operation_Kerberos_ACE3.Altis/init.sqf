/*
	Author: Dorbedo
	
	Description:
		init
*/
#include "script_component.hpp"

////// Autodetection of Mods
/// RDS
DORB_MODS_RDS = (isClass(configFile >> "CfgPatches" >> "RDS_StaticWeapons_Core"));
DORB_MODS_BWA = (isClass(configFile >> "CfgPatches" >> "BWA3_Tracked"));
DORB_PLAYERSIDE = west;

If (DORB_PLAYERSIDE == west) then {
	DORB_RESPAWNMARKER = "respawn_west";
	CIVILIAN setFriend [WEST, 1];

	WEST setFriend [CIVILIAN, 1];
	WEST setFriend [EAST, 0];
	WEST setFriend [INDEPENDENT, 0];

	EAST setFriend [CIVILIAN, 1];
	EAST setFriend [WEST, 0];
	EAST setFriend [INDEPENDENT, 1];

	INDEPENDENT setFriend [CIVILIAN, 1];
	INDEPENDENT setFriend [WEST, 0];
	INDEPENDENT setFriend [EAST, 1];
};
If (DORB_PLAYERSIDE == east) then {
	DORB_RESPAWNMARKER = "respawn_east";
	CIVILIAN setFriend [EAST, 1];

	WEST setFriend [CIVILIAN, 1];
	WEST setFriend [EAST, 0];
	WEST setFriend [INDEPENDENT, 1];

	EAST setFriend [CIVILIAN, 1];
	EAST setFriend [WEST, 0];
	EAST setFriend [INDEPENDENT, 0];

	INDEPENDENT setFriend [CIVILIAN, 1];
	INDEPENDENT setFriend [WEST, 1];
	INDEPENDENT setFriend [EAST, 0];
};

enableSaving [false, false];
enableRadio false;

// Logistik
_r3f = execVM "R3F_LOG\init.sqf";
//_igiload = execVM "IgiLoad\IgiLoadInit.sqf";

// VCOM-Driving
If ((!hasInterface) && (!isServer)) then {
	[] execVM "VCOM_Driving\init.sqf";
};

//Task Force Radio
tf_no_auto_long_range_radio = true;
//tf_same_sw_frequencies_for_side = true;
//TF_give_microdagr_to_soldier = false;
If ((isClass(configFile >> "CfgPatches" >> "rhsusf_c_weapons"))) then {
	["Preload"] call RHS_fnc_arsenal;
}else{
	["Preload"] call BIS_fnc_arsenal;
};

["Initialize"] call BIS_fnc_dynamicGroups;