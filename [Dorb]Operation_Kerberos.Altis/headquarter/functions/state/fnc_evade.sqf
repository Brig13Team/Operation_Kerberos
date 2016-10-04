/*
    Author: Dorbedo

    Description:
        moves to a position by evading enemy contact if possible

    Parameter(s):
        0 : Group - <GROUP>
        1 : Statement to be called after finishing the waypoint <STRING>

    Returns:
        none
*/
#include "script_component.hpp"
_this params[["_group",grpNull,[grpNull,objNull]],["_statementFinish","",[""]]];

_group = _group call CBA_fnc_getGroup;

private _grouphash = _group getVariable "grouphash";
private _target = HASH_GET(_grouphash,"target");

if (IS_OBJECT(_target)) then {_target = getPos _target;};

private _waypoints = [getPos (leader _group),_target] call FUNC(waypoints_evade);

private _lastWaypoint = _waypoints deleteAt ((count _waypoints)-1);

while {(count (waypoints _group)) > 0} do {
    deleteWaypoint ((waypoints _group) select 0);
};

private _statement = "";

[_group,_waypoints,0,"MOVE","COMBAT","GREEN","FULL","NO CHANGE",_statement,[1,3,5],150] call FUNC(waypoints_add);


_statement = QUOTE([ARR_2(this,'idle')] call FUNC(state_set);) + _statementFinish;

[_group, _lastWaypoint, 0, "MOVE", "COMBAT", "YELLOW", "FULL", "NO CHANGE", _statement, [3,6,9], 30] call FUNC(waypoints_add);
