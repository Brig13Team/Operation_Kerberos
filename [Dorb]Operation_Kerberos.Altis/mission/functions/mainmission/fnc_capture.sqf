/*
 *  Author: Dorbedo, iJesuz
 *
 *  Description:
 *      init mission "capture"
 *
 *  Parameter(s):
 *      0 : HASH        - mission hash
 *      1 : [OBJECT]    - mission target
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission", "_targets"];

{
    _x allowFleeing 0;

    _x setVariable [QGVAR(rescueEvent), QFUNC(obj__increaseCounterOne)];
    _x addEventHandler ["Killed", LINKFUNC(obj__increaseCounterTwo)];
} forEach _targets;

[_mission, _targets] call FUNC(mainmission__twoCounters);
