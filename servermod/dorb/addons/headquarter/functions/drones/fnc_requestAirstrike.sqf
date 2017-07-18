/*
    Author: iJesuz

    Description:

    Parameter(s):
        0 : OBJECT/ARRAY - target
        1 : OBJECT - caller

    Returns:
        BOOLEAN
*/
#include "script_component.hpp"

_this params [["_target",objNull,[objNull,[]]],["_caller",objNull,[objNull,locationNull]]];

if !([] call FUNC(drones_canDoAirstrike)) exitWith {false};
GVAR(drones_lastAttackRequest) = CBA_missiontime;

private _task = [
    _target,
    CBA_missiontime + 120,
    _caller
];

GVAR(drones_requestedAirstrikes) pushBack _task;

true
