/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds waypoints to a group
 *
 *  Parameter(s):
 *      0 : GROUP - the group
 *      1 : ARRAY/OBJECT/LOCATION/GROUP - the postion/ a array of poistions
 *      (Optionals)
 *      2 : SCALAR - Radius
 *      3 : STRING - Type of waypoint
 *      4 : STRING - Combat mode
 *      5 : STRING - Speed
 *      6 : STRING - formation
 *      7 : STRING - statement executed when the waypoint is finished
 *      8 : ARRAY - timeout
 *      8 : SCALAR - completetion radius
 *
 *  Returns:
 *      ARRAY - the added waypoints
 *
 */
#define DEBUG_MODE_OFF
#include "script_component.hpp"

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
    ["_compRadius", 5, [0]]
    ];
TRACEV_1(_positions);
if ((IS_ARRAY(_positions))&&{!(IS_ARRAY(_positions select 0))}) then {_positions = [_positions];};
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
    #ifdef DEBUG_MODE_FULL
        [_position,"Waypoint","ColorBlack","Dot"] call EFUNC(common,debug_marker_create);
    #endif
}forEach _positions;

_waypoints
