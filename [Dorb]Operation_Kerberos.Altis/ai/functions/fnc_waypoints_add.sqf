/*
	Author: Dorbedo
	
	Description:
		add waypoints
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(waypoints_add);
_this params[
	["_group",grpNull,[grpNull,objNull]],
	["_positions",[],[[],objNull,locationNull,grpNull]],
	["_radius", 0, [0]],
    ["_type", "MOVE", [""]],
    ["_behaviour", "UNCHANGED", [""]],
    ["_combat", "NO CHANGE", [""]],
    ["_speed", "UNCHANGED", [""]],
    ["_formation", "NO CHANGE", [""]],
    ["_onComplete", "", [""]],
    ["_timeout", [0,0,0], [[]], 3],
    ["_compRadius", 0, [0]]
	
	];
if !(IS_ARRAY(_positions)) then {_positions = [_positions];};
if ((isNull _group)||(_positions isEqualTo [])) exitWith {[]};

private "_waypoints";
_waypoints = [];
_group = _group call CBA_fnc_getGroup;

{
	private ["_waypoint","_position"];
	_position = _x call CBA_fnc_getPos;
	_waypoint = _group addWaypoint [_position, _radius];
	_waypoint setWaypointType _type;
	_waypoint setWaypointBehaviour _behaviour;
	_waypoint setWaypointCombatMode _combat;
	_waypoint setWaypointSpeed _speed;
	_waypoint setWaypointFormation _formation;
	_waypoint setWaypointStatements ["TRUE", _onComplete];
	_waypoint setWaypointTimeout _timeout;
	_waypoint setWaypointCompletionRadius _compRadius;
	_waypoints pushBack _waypoint;
}forEach _positions;

_waypoints