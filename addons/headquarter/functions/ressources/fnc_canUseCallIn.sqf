/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Checks if you can use a callIn attack
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      BOOL - allowed to callIn
 *
 */
#include "script_component.hpp"

_this params [["_type","",[""]]];

switch (_type) do {
    case "airinterception";
    case "helicopter";
    case "drones";
    case "cas" : {
        private _ressourcesHash = HASH_GET_DEF(GVAR(ressources),_type,locationNull);
        If !(HASH_GET_DEF(_ressourcesHash,"isActive",false)) exitWith {false};
        [_type] call FUNC(ressources_CheckIntervall)
    };
    case "radar_airinterception" : {
        ((GVAR(radar_nextAI) < CBA_missiontime)&&{({alive _x} count HASH_GET(GVAR(radars),"objects"))>0})
    };
    // replenish soldiers
    default {[_type] call FUNC(ressources_CanCallInUnits);};
};
