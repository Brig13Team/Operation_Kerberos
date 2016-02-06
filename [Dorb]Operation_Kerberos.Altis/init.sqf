/*
    Author: Dorbedo
    
    Description:
        init
*/

#include "script_component.hpp"

GVARMAIN(playerside) = west;
enableSaving [false, false];
enableRadio false;

[] call FUNC(init);

/// Mod-Specific
tf_no_auto_long_range_radio = true;

["Initialize"] call BIS_fnc_dynamicGroups;

If (isServer) then {
    setTimeMultiplier 2;
};

If (isHeadless) then {
    [] execVM "VCOM_Driving\init.sqf";
};

If (hasInterface) then {
    waituntil {! isnull player};
    ["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
    [
        LSTRING(CLAN),
        [LSTRING(WELCOME1),LSTRING(WELCOME2),LSTRING(WELCOME3),LSTRING(WELCOME4),LSTRING(WELCOME5),LSTRING(WELCOME6)],
        "data\logo_brig.paa",
        false
    ] call EFUNC(interface,disp_info);
};