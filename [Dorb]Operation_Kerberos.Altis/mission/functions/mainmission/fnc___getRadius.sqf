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
 *      -
 */
#include "script_component.hpp"

_this params ["_type"];

if (!isNumber(missionConfigFile >> "missions_config" >> "main" >> _type >> "location" >> "distance")) throw "no distance";
private _distance = getNumber(missionConfigFile >> "missions_config" >> "main" >> "radiotower" >> "location" >> "distance");

_distance
