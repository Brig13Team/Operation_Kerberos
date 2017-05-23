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
    case "artilleries" : {(count (GVAR(FDC_artilleries) select {(alive _x)&&{alive (gunner _x)}&&{((_x getVariable [QGVAR(lastShotdone),0])<CBA_missiontime)}})) > 0};
    case "mortars" : {(count (GVAR(FDC_mortars) select {(alive _x)&&{alive (gunner _x)}&&{((_x getVariable [QGVAR(lastShotdone),0])<CBA_missiontime)}})) > 0};
    case "rockets" : {(count (GVAR(FDC_rockets) select {(alive _x)&&{alive (gunner _x)}&&{((_x getVariable [QGVAR(lastShotdone),0])<CBA_missiontime)}})) > 0};
    default {false};
};
