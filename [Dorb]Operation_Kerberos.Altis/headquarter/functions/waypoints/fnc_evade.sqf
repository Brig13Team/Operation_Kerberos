/*
    Author: Dorbedo

    Description:


    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
params[["_key","",[""]],["_distance",0,[0]]];
If (_key isEqualTo "") exitWith {0};
If (HASH_HASHKEY(GVAR(waypoints),_key)) exitWith {
    _distance * HASH_GET(GVAR(waypoints),_key);
};
0;
