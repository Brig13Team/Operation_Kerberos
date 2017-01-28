/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns if the fdc can use supporttype
 *
 *  Parameter(s):
 *      0 : STRING - Supporttype
 *
 *  Returns:
 *      BOOL - can use supporttype
 *
 */
#include "script_component.hpp"

_this params [["_supporttype","",[""]]];

switch (_supporttype) do {
    case "artillery";
    case "artilleries" : {(count (HASH_GET(GVAR(FDC),"artilleries") select {alive _x})) > 0};
    case "mortars" : {(count (HASH_GET(GVAR(FDC),"mortars") select {alive _x})) > 0};
    case "rockets" : {(count (HASH_GET(GVAR(FDC),"rockets") select {alive _x})) > 0};
    default {false};
};
