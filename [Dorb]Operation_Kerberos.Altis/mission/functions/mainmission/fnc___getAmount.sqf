/*
 *  Author: iJesuz
 *
 *  Description:
 *      get random amount of mission targets
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

if (isClass(missionConfigFile >> "mission" >> "main" >> _type >> "object")) exitWith {
    if !(isNumber(missionConfigFile >> "mission" >> "main" >> _type >> "object" >> "min")) throw "no min (main)";
    if !(isNumber(missionConfigFile >> "mission" >> "main" >> _type >> "object" >> "max")) throw "no max (main)";

    private _min = getNumber(missionConfigFile >> "mission" >> "main" >> _type >> "object" >> "min");
    private _max = getNumber(missionConfigFile >> "mission" >> "main" >> _type >> "object" >> "max");
    private _avg = (floor (random ((_max - _min) + 1))) + _min;

    _avg
};

if (isClass(missionConfigFile >> "mission" >> "side" >> _type >> "object")) then {
    if !(isNumber(missionConfigFile >> "mission" >> "side" >> _type >> "object" >> "min")) throw "no min (main)";
    if !(isNumber(missionConfigFile >> "mission" >> "side" >> _type >> "object" >> "max")) throw "no max (main)";

    private _min = getNumber(missionConfigFile >> "mission" >> "side" >> _type >> "object" >> "min");
    private _max = getNumber(missionConfigFile >> "mission" >> "side" >> _type >> "object" >> "max");
    private _avg = (floor (random ((_max - _min) + 1))) + _min;

    _avg
};

throw "mission not found";
