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

private ["_lastRequest"];
params[["_target",objNull,[objNull,[]]],["_caller",objNull,[objNull]],["_code",{},[{}]]];

_lastRequest = GETVAR(_caller,GVAR(lastReconRequest),-1);

if ((lastReconRequest != -1) && ((lastReconRequest + 600) >= serverTime)) exitWith { false };
SETVAR(_caller,GVAR(lastAttackRequest),serverTime);

_task = [
    _target,
    serverTime + 600,
    _caller,
    _code
];

_requestedReconnaissances = GETMVAR(GVAR(requestedReconnaissances),[]);
_requestedReconnaissances pushBack _task;

SETMVAR(missionNamespace,GVAR(requestedReconnaissances),_requestedReconnaissances);

true