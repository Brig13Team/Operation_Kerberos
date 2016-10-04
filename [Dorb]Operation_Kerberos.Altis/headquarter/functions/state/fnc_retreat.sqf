/*
    Author: Dorbedo

    Description:
        retreats

    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
_this params[["_group",grpNull,[grpNull,objNull]]];
private["_statement","_target","_waypoints","_lastWaypoint"];
_group = _group call CBA_fnc_getGroup;

private _grouphash = _group getVariable "grouphash";
private _target = HASH_GET(_grouphash,"target");

if (IS_OBJECT(_target)) then {_target = getPos _target;};

_waypoints = [getPos (leader _group),_target] call FUNC(waypoints_generate);

_lastWaypoint = _waypoints deleteAt ((count _waypoints)-1);

while {(count (waypoints _group)) > 0} do {
    deleteWaypoint ((waypoints _group) select 0);
};

_statement = "";

[_group,_waypoints,0,"MOVE","COMBAT","GREEN","FULL","NO CHANGE",_statement,[1,3,5],30] call FUNC(waypoints_add);


_statement = QUOTE([ARR_2(this,'idle')] call FUNC(state_set);) + _statementFinish;

[_group, _lastWaypoint, 0, "MOVE", "COMBAT", "YELLOW", "FULL", "NO CHANGE", _statement, [3,6,9], 30] call FUNC(waypoints_add);
