/*
 *  Author: iJesuz
 *
 *  Description:
 *      get spawn radius of mission
 *      (can be used for sidemission too)
 *
 *  Parameter(s):
 *      0 : STRING  - name
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_type"];

// _type is a main mission
if (isNumber(missionConfigFile >> "mission" >> "main" >> _type >> "object" >> "radius")) exitWith {
    getNumber(missionConfigFile >> "mission" >> "main" >> _type >> "object" >> "radius")
};

// _type is a side mission
if (isNumber(missionConfigFile >> "mission" >> "side" >> _type >> "object" >> "radius")) exitWith {
    getNumber(missionConfigFile >> "mission" >> "side" >> _type >> "object" >> "radius")
};

// _type is neither main nor side mission
throw "no radius";
