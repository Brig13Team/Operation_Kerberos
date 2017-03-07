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
    // _this params ["_intel"];
    // _intel setVariable [QGVAR(rescueEvent), QGVAR(intel_found)];
}] call FUNC(mainmission__oneCounter);
