/*
    Author: Dorbedo
    
    Description:
        init
*/

#include "script_component.hpp"

GVARMAIN(playerside) = west;
enableSaving [false, false];
enableRadio false;

/// Mod-Specific
tf_no_auto_long_range_radio = true;

["Initialize"] call BIS_fnc_dynamicGroups;

If (isServer) then {
    setTimeMultiplier 2;
};
