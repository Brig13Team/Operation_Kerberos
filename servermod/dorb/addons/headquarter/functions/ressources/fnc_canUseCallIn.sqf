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
    case "cas" : {
        If !([_type] call FUNC(ressources_CheckIntervall)) exitWith {false;};
        private _ressourcesHash = HASH_GET_DEF(GVAR(ressources),_type,locationNull);
        private _units = HASH_GET_DEF(_ressourcesHash,"units",[]) select {alive _x};
        private _amount = HASH_GET_DEF(_ressourcesHash,"amount",0);
        ((count _units)<_amount);
    };
    case "radar_airinterception" : {
        ((GVAR(radar_nextAI) < CBA_missiontime)&&{({alive _x} count HASH_GET(GVAR(radars),"objects"))>0})
    };
    case "drones" : {
        (GVARMAIN(side_type) == "droneoperations")
    };
    // replenish soldiers
    default {[_type] call FUNC(ressources_CanCallInUnits);};
};
