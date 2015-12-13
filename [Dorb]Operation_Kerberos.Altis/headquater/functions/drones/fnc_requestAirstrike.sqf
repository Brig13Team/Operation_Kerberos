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
SCRIPT(requestAirstrike);

private ["_task","_requestedAirstrikes","_lastRequest"];
params [["_target",objNull,[objNull,[]]],["_caller",objNull,[objNull]]];

_lastRequest = GETVAR(_caller,GVAR(lastAttackRequest),-1);

if ((_lastRequest != -1) && ((_lastRequest + 600) >= serverTime)) exitWith { false };
SETVAR(_caller,GVAR(lastAttackRequest),serverTime);

_task = [
    _target,
    serverTime + 600,
    _caller
];

_requestedAirstrikes = GETVAR(missionNamespace,GVAR(requestedAirstrikes),[]);
_requestedAirstrikes pushBack _task;

SETVAR(missionNamespace,GVAR(requestedAirstrikes),_requestedAirstrikes);

true