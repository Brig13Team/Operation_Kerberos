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
        private _unit = ["cas"] call EFUNC(spawn,getUnit);
        ((([_unit] call FUNC(getCost)) + GVAR(ressources_amount)) > 0);
    };
    case "airinterception" : {
        private _unit = ["plane_ai"] call EFUNC(spawn,getUnit);
        ((([_unit] call FUNC(getCost)) + GVAR(ressources_amount)) > 0);
    };
    case "helicopter" : {
        private _unit = ["helicopter"] call EFUNC(spawn,getUnit);
        ((([_unit] call FUNC(getCost)) + GVAR(ressources_amount)) > 0);
    };
    case "drones" : {
        (GVARMAIN(side_type) == "droneoperations")
    };

    default {[_type] call FUNC(ressources_CanCallInUnits);};
};
