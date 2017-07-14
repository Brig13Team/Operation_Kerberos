/*
 *  Author: iJesuz
 *
 *  Description:
 *      get spawn radius of mission
 *
 *  Parameter(s):
 *      0 : STRING  - name
 *
 *  Returns:
 *      NUMBER (default: 200)
 */
#include "script_component.hpp"

_this params ["_type"];

// _type is a main mission
if (isNumber(ConfigFile >> "CfgKerberos" >> "mainmissions" >> _type >> "location" >> "radius")) exitWith {
    getNumber(ConfigFile >> "CfgKerberos" >> "mainmissions" >> _type >> "location" >> "radius")
};

// _type is a side mission
if (isNumber(ConfigFile >> "CfgKerberos" >> "sidemissions" >> _type >> "location" >> "radius")) exitWith {
    getNumber(ConfigFile >> "CfgKerberos" >> "sidemissions" >> _type >> "location" >> "radius")
};

200
