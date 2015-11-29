/*
	Author: Dorbedo
	
	Description:
		changes the state
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(state_change);
_this params[["_group",grpNull,[grpNull,objNull]]];

_group = _group call CBA_fnc_getGroup;
_state = GETVAR(_group,GVAR(state),'');

switch (_state) do {
	case "patrol" : {[_group, getPos (leader _group), "AWARE", "WHITE", "NORMAL", "NO CHANGE", "", [5,10,15]] call EFUNC(spawn,patrol_task);};
	case "attack" : {[_group] call FUNC(state_attack);};
	case "evade" : {[_group] call FUNC(state_evade);};
	case "idle" : {[_group] call FUNC(state_idle);};
	case "retreat" : {[_group] call FUNC(state_retreat);};
};


