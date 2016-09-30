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
params[["_key","",[""]],["_distance",0,[0]]];
If (_key isEqualTo "") exitWith {0};
If (HASH_HASKEY(GVAR(WP_deaktivated),_key)) exitWith {999999};
(HASH_GET(GVAR(WP_hashes)),_key)*_distance;
