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
    case "cas" : {
        private _unit = ["plane_cas"] call EFUNC(spawn,getUnit);
        private _aliveCas = GVAR(callInUnits_cas) select {alive _x};
        private _amount = getNumber(missionConfigFile >> QEGVAR(spawn,unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "amountCAS") min 1;
        (((([_unit] call FUNC(getCost)) + GVAR(ressources_amount)) > 0)&&{(count _aliveCas) < _amount});
    };
    case "airinterception" : {
        private _unit = ["plane_ai"] call EFUNC(spawn,getUnit);
        private _aliveAI = GVAR(callInUnits_ai) select {alive _x};
        private _amount = getNumber(missionConfigFile >> QEGVAR(spawn,unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "amountAI") min 1;
        (((([_unit] call FUNC(getCost)) + GVAR(ressources_amount)) > 0)&&{(count _aliveAI) < _amount});
    };
    case "radar_airinterception" : {
        ((GVAR(radar_nextAI) < CBA_missiontime)&&{({alive _x} count HASH_GET(GVAR(radars),"objects"))>0})
    };
    case "helicopter" : {
        private _unit = ["helicopter"] call EFUNC(spawn,getUnit);
        private _aliveHeli = GVAR(callInUnits_heli) select {alive _x};
        private _amount = getNumber(missionConfigFile >> QEGVAR(spawn,unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "amountHeli") min 1;
        (((([_unit] call FUNC(getCost)) + GVAR(ressources_amount)) > 0)&&{(count _aliveHeli) < _amount});
    };
    case "drones" : {
        (GVARMAIN(side_type) == "droneoperations")
    };
    // replenish soldiers
    default {[_type] call FUNC(ressources_CanCallInUnits);};
};
