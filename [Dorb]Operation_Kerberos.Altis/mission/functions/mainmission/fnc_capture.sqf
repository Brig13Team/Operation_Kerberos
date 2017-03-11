/*
 *  Author: Dorbedo, iJesuz
 *
 *  Description:
 *      Mission "Capture"
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
    _this params ["_commander"];

    _commander setVariable [QGVAR(rescueEvent), QFUNC(obj__increaseCounterOne)];
    _commander addEventHandler ["Killed", LINKFUNC(obj__increaseCounterTwo)];
}] call FUNC(mainmission__twoCounters);
