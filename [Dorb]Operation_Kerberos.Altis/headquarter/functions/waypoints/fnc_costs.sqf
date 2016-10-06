/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the cost of a waypoint
 *
 *  Parameter(s):
 *      0 : STRING - the waypoint key
 *      1 : SCALAR - distance to the next waypoint
 *
 *  Returns:
 *      SCALAR - waypoint cost
 *
 */
#include "script_component.hpp"

#include "script_component.hpp"
params[["_key","",[""]],["_distance",0,[0]]];
If (_key isEqualTo "") exitWith {0};
If (HASH_HASHKEY(GVAR(waypoints),_key)) exitWith {
    _distance * HASH_GET(GVAR(waypoints),_key);
};
0;
