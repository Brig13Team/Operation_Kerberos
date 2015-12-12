/*
    Author: Dorbedo
    
    Description:
        evades
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
SCRIPT(state_evade);
_this params[["_group",grpNull,[grpNull,objNull]],["_statementFinish","",[""]]];
private["_statement","_target","_waypoints","_lastWaypoint"];
_group = _group call CBA_fnc_getGroup;

_target = GETVAR(_group,GVAR(target),objNull);
if (IS_OBJECT(_target)) then {_target = getPos _target;};

_waypoints = [getPos (leader _group),_target] call FUNC(waypoints_evade);

_lastWaypoint = _waypoints deleteAt ((count _waypoints)-1);

while {(count (waypoints _group)) > 0} do {
    deleteWaypoint ((waypoints _group) select 0);
};

_statement = "";

[_group,_waypoints,0,"MOVE","COMBAT","GREEN","FULL","NO CHANGE",_statement,[1,3,5],150] call FUNC(waypoints_add);


_statement = QUOTE((group this) setVariable ['GVAR(state)','idle'];[this] call FUNC(state_change);) + _statementFinish;

[_group, _lastWaypoint, 0, "MOVE", "COMBAT", "YELLOW", "FULL", "NO CHANGE", _statement, [3,6,9], 30] call FUNC(waypoints_add);

