/*
	Author: Dorbedo
	
	Description:
		attacks
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(behavior_attack);
_this params[["_group",grpNull,[grpNull,objNull]]];
private["_statement","_target","_waypoints","_lastWaypoint"];
_group = _group call CBA_fnc_getGroup;

_target = GETVAR(_group,GVAR(target),objNull);

If !(Alive _target) exitWith {
	SETVAR(_group,GVAR(behavior),'idle');
	[_group] call FUNC(behavior_change);
};

_waypoints = [_group,_target] call FUNC(waypoints_generate);

_lastWaypoint = _waypoints deleteAt ((count _waypoints)-1);

deleteWaypoint[_group,all];

_statement = QUOTE(If !(alive ((leader this) getVariable ['GVAR(target)',objNull])) then {_group setVariable ['GVAR(behavior)','idle'];[this] call FUNC(behavior_change);};);


[_group,_waypoints,0,"MOVE","COMBAT","YELLOW","FULL","NO CHANGE",_statement,[1,3,5],30] call FUNC(waypoints_add);


_statement = QUOTE((group this) setVariable ['GVAR(behavior)','idle'];[this] call FUNC(behavior_change););

[_group, _lastWaypoint, 0, "SAD", "COMBAT", "RED", "FULL", "NO CHANGE", _statement, [3,6,9], 30] call CBA_fnc_addWaypoint;

