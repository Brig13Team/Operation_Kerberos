/*
	Author: Dorbedo
	
	Description:
		changes the behavior
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(behavior_change);
_this params[["_group",grpNull,[grpNull,objNull]]];

_group = _group call CBA_fnc_getGroup;
_behavior = GETVAR(_group,GVAR(behavior),'');

switch (_behavior) do {
	case "patrol" : {[_group, getPos (leader _group), "AWARE", "WHITE", "NORMAL", "NO CHANGE", "", [5,10,15]] call EFUNC(spawn,patrol_task);};
	case "attack" : {[_group] call FUNC(behavior_attack);};
	case "evade" : {[_group] call FUNC(behavior_evade);};
	case "idle" : {[_group] call FUNC(behavior_idle);};
	case "retreat" : {[_group] call FUNC(behavior_retreat);};
};


