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
    _this params ["_obj"];
    _obj setVariable [QGVAR(rescueEvent), QGVAR(commander_captured)];
    _obj addEventHandler ["Killed", LINKFUNC(obj_onCommanderKilled)];
}] call FUNC(mainmission__twoCounters);
