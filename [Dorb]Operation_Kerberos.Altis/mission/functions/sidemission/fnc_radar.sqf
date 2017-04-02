/*
 *  Author: iJesuz
 *
 *  Description:
 *      Mission "Radar"
 *
 *  Parameter(s):
 *      0 : HASH      - mission hash
 *      1 : [OBJECT]  - mission targets
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission", "_targets"];

{
    _x addEventHandler ["Killed", LINKFUNC(obj__increaseCounter)];
} forEach _targets;

[_mission, _targets] call FUNC(mainmission__oneCounter);
