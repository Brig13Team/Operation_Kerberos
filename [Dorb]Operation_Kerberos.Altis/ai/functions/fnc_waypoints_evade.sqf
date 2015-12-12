/*
    Author: Dorbedo
    
    Description:
        generates waypoints
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
SCRIPT(waypoints_evade);
params[["_key","",[""]],["_distance",0,[0]]];
If (_key isEqualTo "") exitWith {0};
If (_key in GVAR(WP_deaktivated)) exitWith {999999};
(([GVAR(WP_hashes),_key] call CBA_fnc_hashGet))*(_distance)