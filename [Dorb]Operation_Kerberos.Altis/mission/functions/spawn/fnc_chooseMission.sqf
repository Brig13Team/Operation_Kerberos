/*
 *  Author: iJesuz
 *
 *  Description:
 *      choose random mission from config
 *
 *  Parameter(s):
 *      0 : STRING  - "main" or "side"
 *
 *  Returns:
 *      STRING
 */
#include "script_component.hpp"

_this params ["_mainOrSide"];

private _classes = "true" configClasses (missionConfigFile >> "mission" >> _mainOrSide)
                        select { !(([configName _x, 0, 2] call CBA_fnc_substr) isEqualTo "__") AND !((configName _x) isEqualTo "rtb") }
                        select { if !(isText(_x >> "condition")) then { true } else { [] call compile getText(_x >> "condition") } };

configName ([_classes, _classes apply { getNumber(_x >> "probability") }] call BIS_fnc_selectRandomWeighted)
