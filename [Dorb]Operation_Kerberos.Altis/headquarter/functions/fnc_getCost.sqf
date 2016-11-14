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

_this params [["_type","",[""]]];
If (_type isEqualTo "") exitWith {0};

getNumber(configFile >> "CfgVehicles" >> _type >> "cost");
