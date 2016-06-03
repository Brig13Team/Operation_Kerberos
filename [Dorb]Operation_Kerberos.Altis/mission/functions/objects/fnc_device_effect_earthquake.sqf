/*
    Author: Dorbedo
    
    Description:
        
    
*/
#include "script_component.hpp"
SCRIPT(device_effect_earthquake);

_this params ["_target"];

ISNILS(GVAR(device_intervall),CBA_missionTime);

If (GVAR(device_intervall)>diag_ticktime) exitWith {};

["earthquake",[]] call CBA_fnc_globalEvent;

GVAR(earthquake_nextIntervall) = 7 * 60 + (floor(random 3)) * 60;
