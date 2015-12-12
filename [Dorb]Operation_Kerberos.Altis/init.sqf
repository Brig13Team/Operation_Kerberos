/*
    Author: Dorbedo
    
    Description:
        init
*/
#include "script_component.hpp"
SCRIPT(init);

GVARMAIN(playerside) = west;
enableSaving [false, false];
enableRadio false;

[] call FUNC(init);

/// Mod-Specific
tf_no_auto_long_range_radio = true;

If ((!hasInterface) && (!isServer)) then {
    [] execVM "VCOM_Driving\init.sqf";
};

["Initialize"] call BIS_fnc_dynamicGroups;

