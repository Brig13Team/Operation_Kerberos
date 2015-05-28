/*
	Author: Dorbedo
	
	Description:
		init
*/
#include "makros.hpp"

MAKROS = (parsingNamespace getVariable "D_ROOTDIR")+"makros.hpp";
ICONS_DIR = (parsingNamespace getVariable "D_ROOTDIR")+"data\icons\";

execVM "shk_taskmaster.sqf";

enableSaving [false, false];
enableRadio false;

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



// Logistik
_r3f = execVM "R3F_LOG\init.sqf";
_igiload = execVM "IgiLoad\IgiLoadInit.sqf";

// VCOM-Driving
[] execVM "VCOM_Driving\init.sqf";

//Task Force Radio
tf_no_auto_long_range_radio = true;
//tf_same_sw_frequencies_for_side = true;
//TF_give_microdagr_to_soldier = false;

["Initialize"] call BIS_fnc_dynamicGroups;  
CHECK(!hasInterface)
["init"] FSPAWN(grouptracker);