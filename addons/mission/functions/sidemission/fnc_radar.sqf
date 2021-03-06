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
    _x addEventHandler ["Killed", LINKFUNC(statemachine_increaseCounter)];
    [QEGVAR(headquarter,registerRadar),[_x]] call CBA_fnc_serverEvent;
    _x setVariable [QGVAR(isActive),true];
} forEach _targets;

//[_mission, _targets] call FUNC(mainmission__oneCounter);
_targets
