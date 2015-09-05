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

_lastRequest = GETVAR(_caller,GVAR(lastRequest),-1);

if ((_lastRequest != -1) && ((_lastRequest + 600) >= serverTime)) exitWith { false };

_task = [];
_task pushBack _target;
_task pushBack (serverTime + 600);
_task pushBack _caller;

_requestedAirstrikes = GETVAR(missionNamespace,GVAR(requestedAirstrikes),[]);
_requestedAirstrikes pushBack _task;

SETVAR(missionNamespace,GVAR(requestedAirstrikes),_requestedAirstrikes);

true