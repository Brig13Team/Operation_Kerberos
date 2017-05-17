/*
 *  Author: iJesuz
 *
 *  Description:
 *      init mission "prototype"
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
    _x setVariable [QGVAR(rescueEvent), QFUNC(mainmission_prototype_rescued)];
    _x addEventHandler["Killed", LINKFUNC(obj__triggerFailed)];
    HASH_SET(_mission, "prototype", typeOf _x);
} forEach _targets;

//[_mission, _targets] call FUNC(mainmission__oneCounter);
