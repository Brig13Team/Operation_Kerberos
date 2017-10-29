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
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_group"];

private _target = _group getVariable [QGVAR(target),locationNull];

private _targetPos = [_target] call CBA_fnc_getPos;
_targetPos set [2,400];

TRACEV_2(_target,_targetPos);

[_group] call CBA_fnc_clearWaypoints;
private _wp = _group addWaypoint [_targetPos, 0];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointCombatMode "RED";
