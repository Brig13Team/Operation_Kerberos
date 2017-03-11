/*
 *  Author: iJesuz
 *
 *  Description:
 *      Mission "Hostage"
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission"];

[_mission, {
    _this params ["_hostage"];

    _hostage setVariable [QGVAR(rescueEvent), QFUNC(obj__increaseCounterOne)];
    _hostage addEventHandler ["Killed", LINKFUNC(obj__incraseCounterTwo)];
}] call FUNC(mainmission__twoCounters);
