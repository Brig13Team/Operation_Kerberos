/*
 *  Author: Dorbedo
 *
 *  Description:
 *      checks the callIn Intervall
 *
 *  Parameter(s):
 *      0 : STRING - Type of callIn
 *
 *  Returns:
 *      BOOL - Intervall is reached
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_type","",[""]]];

switch (_type) do {
    case "cas" : {
        private _hash = HASH_GET_DEF(GVAR(ressources),"cas",locationNull);
        (HASH_GET_DEF(_hash,"nextexecution",-1) < CBA_missiontime)
    };
    case "airinterception" : {
        private _hash = HASH_GET_DEF(GVAR(ressources),"airinterception",locationNull);
        (HASH_GET_DEF(_hash,"nextexecution",-1) < CBA_missiontime)
    };
    case "helicopter" : {
        private _hash = HASH_GET_DEF(GVAR(ressources),"helicopter",locationNull);
        (HASH_GET_DEF(_hash,"nextexecution",-1) < CBA_missiontime)
    };
    case "drones" : {
         private _hash = HASH_GET_DEF(GVAR(ressources),"drones",locationNull);
        (HASH_GET_DEF(_hash,"nextexecution",-1) < CBA_missiontime)
    };
    default {true};
};
