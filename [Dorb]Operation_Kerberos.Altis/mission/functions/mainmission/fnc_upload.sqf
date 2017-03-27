/*
 *  Author: iJesuz
 *
 *  Description:
 *      init mission "upload"
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
    _x setVariable [QGVAR(isActive), true, true];
} forEach _targets;

[_mission, _targets] call FUNC(mainmission__oneCounter);
