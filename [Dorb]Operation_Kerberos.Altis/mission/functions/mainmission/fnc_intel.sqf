/*
 *  Author: iJesuz
 *
 *  Description:
 *      Mission "Intel"
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
    _this setVariable [QGVAR(rescueEvent), QGVAR(intel_found)];
}] call FUNC(mainmission___oneCounter);
