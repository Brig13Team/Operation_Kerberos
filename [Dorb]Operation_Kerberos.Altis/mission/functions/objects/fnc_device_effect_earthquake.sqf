/*
    Author: Dorbedo
    
    Description:
        
    
*/
#include "script_component.hpp"

_this params ["_target"];

ISNILS(GVAR(device_intervall),diag_ticktime);

If (GVAR(device_intervall)>diag_ticktime) exitWith {};

[QGVAR(earthquake),[]] call CBA_fnc_globalEvent;

GVAR(earthquake_nextIntervall) = 7 * 60 + (floor(random 3)) * 60;
