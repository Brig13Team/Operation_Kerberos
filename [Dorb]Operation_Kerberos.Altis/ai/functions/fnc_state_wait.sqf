/*
	Author: Dorbedo
	
	Description:
		attacks Position
	
	Parameter(s):
		0 : GROUP -Group

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(state_attack);
_this params[["_group",grpNull,[grpNull,objNull]]];
private["_statement","_target","_waypoints","_lastWaypoint"];
_group = _group call CBA_fnc_getGroup;

_target = GETVAR(_group,GVAR(target),objNull);

if (IS_OBJECT(_target)) then {
	_waypoints = [getPos (leader _group),getPos _target] call FUNC(waypoints_generate);
	_statement = QUOTE(If !(alive ((group this) getVariable ['GVAR(target)',objNull])) then {_group setVariable ['GVAR(state)','idle'];[this] call FUNC(state_change);};);

}else{
	_waypoints = [getPos (leader _group),_target] call FUNC(waypoints_generate);
	_statement = "";
};

_lastWaypoint = _waypoints deleteAt ((count _waypoints)-1);

deleteWaypoint[_group,all];

[_group,_waypoints,0,"MOVE","AWARE","YELLOW","NORMAL","NO CHANGE",_statement,[1,3,5],30] call FUNC(waypoints_add);


_statement = QUOTE((group this) setVariable ['GVAR(state)','retreat'];[this] call FUNC(state_change););

[_group, _lastWaypoint, 0, "DISMISS", "SAFE", "GREEN", "LIMITED", "NO CHANGE", _statement, [3,6,9], 30] call FUNC(waypoints_add);

