/*
 *  Author: iJesuz
 *
 *  Description:
 *      init mission "hostage"
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
    [_x, true] call ace_captives_fnc_setHandcuffed;
    removeAllAssignedItems _x;
    removeAllWeapons _x;
    removeBackpack _x;

    _x setVariable [QGVAR(rescueEvent), QFUNC(obj__increaseCounterOne)];
    _x addEventHandler ["Killed", LINKFUNC(obj__increaseCounterTwo)];
} forEach _targets;

[_mission, _targets] call FUNC(mainmission__twoCounters);
