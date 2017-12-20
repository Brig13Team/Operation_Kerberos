/*
    Author: iJesuz

    Description:

    Parameter(s):
        0 : OBJECT/ARRAY - target
        1 : OBJECT - caller
        2 : CODE - code (optional)

    Returns:
        BOOLEAN

*/
#include "script_component.hpp"
SCRIPT(requestReconnaissance);

params[["_target",objNull,[objNull,[]]],["_caller",objNull,[objNull]],["_code",{},[{}]]];

if !([] call FUNC(drones_canDoReconnaissance)) exitWith {false};
GVAR(drones_lastReconRequest) = CBA_missiontime;

_task = [
    _target,
    serverTime + 600,
    _caller,
    _code
];

GVAR(drones_requestedReconnaissances) pushBack _task;

true
