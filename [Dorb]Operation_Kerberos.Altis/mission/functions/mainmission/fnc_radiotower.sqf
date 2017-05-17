/*
 *  Author: iJesuz
 *
 *  Description:
 *      init mission "radiotower"
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
    _x setVectorUp [0,0,1];

    _x setVariable [QGVAR(isActive), true, true];
    _x addEventHandler ["HandleDamage", LINKFUNC(obj_onRadiotowerDamaged)];
} forEach _targets;

//[_mission, _targets] call FUNC(mainmission__oneCounter);
