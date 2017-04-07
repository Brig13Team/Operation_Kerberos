/*
 *  Author: Dorbedo
 *
 *  Description:
 *      gets the cost of a unit
 *
 *  Parameter(s):
 *      0 : STRING - Unitclass
 *
 *  Returns:
 *      SCLALAR - costa of a Unit
 *
 */
#include "script_component.hpp"

_this params [["_type",""]];
If ((_type isEqualType "")||{_type isEqualTo ""}) exitWith {0};

switch (_type) do {
    case ("rhsusf_f22"): {
        4000000;
    };
    default {
        getNumber(configFile >> "CfgVehicles" >> _type >> "cost");
    };
};
