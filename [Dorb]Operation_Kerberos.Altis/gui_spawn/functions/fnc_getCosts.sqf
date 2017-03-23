/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params [["_configname","",[""]]];

If (_configname isEqualTo "") exitWith {0};

getNumber(configFile >> "CfgVehicles" >> _configname >> "costs");
