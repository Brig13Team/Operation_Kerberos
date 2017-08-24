/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the cost of a vehcleclass
 *
 *  Parameter(s):
 *      0 : STRING - Classname
 *
 *  Returns:
 *      Number
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params [["_configname","",[""]]];

If (_configname isEqualTo "") exitWith {0};

getNumber(configFile >> "CfgVehicles" >> _configname >> "costs");
