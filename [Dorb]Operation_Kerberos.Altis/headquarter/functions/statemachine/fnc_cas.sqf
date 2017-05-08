/*
 *  Author: Dorbedo
 *
 *  Description:
 *      handles a cas attack
 *
 *  Parameter(s):
 *      0 : GROUP - The cas-group
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_group"];

private _targetPos = [_group] call CBA_fnc_getPos;
_targetPos set [2,300];

[_group] call CBA_fnc_clearWaypoints;

private _wp = _group addWaypoint [_targetPos, 0];
_wp setWaypointType "LOITER";
_wp setWaypointLoiterType "CIRCLE";
_wp setWaypointLoiterRadius 800;
_wp setWaypointBehaviour "SAD";
_wp setWaypointCombatMode "RED";
