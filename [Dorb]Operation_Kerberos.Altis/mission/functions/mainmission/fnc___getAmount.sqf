/*
 *  Author: iJesuz
 *
 *  Description:
 *      get random amount of mission targets
 *
 *  Parameter(s):
 *      0 : STRING  - name
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_type"];

if (!isNumber(missionConfigFile >> "missions_config" >> "main" >> _type >> "objectsamount_min")) throw "no min";
if (!isNumber(missionConfigFile >> "missions_config" >> "main" >> _type >> "objectsamount_max")) throw "no max";

private _min = getNumber(missionConfigFile >> "missions_config" >> "main" >> _type >> "objectsamount_min");
private _max = getNumber(missionConfigFile >> "missions_config" >> "main" >> _type >> "objectsamount_max");
private _avg = (floor (random ((_max - _min) + 1))) + _min;

_avg
