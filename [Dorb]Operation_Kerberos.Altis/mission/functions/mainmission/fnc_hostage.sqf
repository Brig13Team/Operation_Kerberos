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
    _this params ["_obj"];
    _obj setVariable [QGVAR(rescueEvent), QGVAR(hostage_rescued)];
    _obj addEventHandler ["Killed", LINKFUNC(obj_onHostageKilled)];
}] call FUNC(mainmission__twoCounters);
