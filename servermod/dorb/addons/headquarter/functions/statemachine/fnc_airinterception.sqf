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

private _target = _group getVariable [QGVAR(target),locationNull];

private _targetPos = [_target] call CBA_fnc_getPos;
_targetPos set [2,1000];


[_group] call CBA_fnc_clearWaypoints;
private _wp = _group addWaypoint [_targetPos, 0];
_wp setWaypointType "LOITER";
_wp setWaypointLoiterType "CIRCLE";
_wp setWaypointLoiterRadius 1500;
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointCombatMode "RED";
