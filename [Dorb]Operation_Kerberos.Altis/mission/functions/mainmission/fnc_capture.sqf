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
    _this setVariable [QGVAR(rescueEvent), QGVAR(commander_captured)];
    _this addEventHandler ["Killed", LINKFUNC(obj_onCommanderKilled)];
}] call FUNC(mainmission___twoCounters);
