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
_state = toLower (GETVAR(_group,GVAR(state),''));

switch (_state) do {
	case "patrol" : {
			private ["_formation","_position"];
			_formation = ["COLUMN","STAG COLUMN","WEDGE","VEE","FILE","DIAMOND"] SELRND;
			_position = GETVAR(_group,GVAR(target),getPos (leader group));
			[_group, _position, "AWARE", "WHITE", "NORMAL", "NO CHANGE", "", [5,10,15]] call EFUNC(spawn,patrol_task);
		};
	case "attack" : {[_group] call FUNC(state_attack);};
	case "evade" : {[_group] call FUNC(state_evade);};
	case "idle" : {[_group] call FUNC(state_idle);};
	case "retreat" : {[_group] call FUNC(state_retreat);};
	case "wait" : {[_group] call FUNC(state_wait);};
	case "defend" : {[_group] call FUNC(state_defend);};
};
