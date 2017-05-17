/*
 *  Author: Dorbedo
 *
 *  Description:
 *      execution of the attack state
 *
 *  Parameter(s):
 *      0 : GROUP/OBJECT - The group/the group of a unit attacks a location
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"
CHECK(!isServer)
_this params[["_group",grpNull,[grpNull,objNull]]];

_group = _group call CBA_fnc_getGroup;

private _target = _group getVariable [QGVAR(target),locationNull];
CHECK(isNull _target)

private _targetPos = [locationPosition _target,50] call EFUNC(common,pos_random);
private _waypoints = [getPos (leader _group),_targetPos] call FUNC(waypoints_generate);

private _lastWaypoint = _waypoints deleteAt ((count _waypoints)-1);

[_group] call CBA_fnc_clearWaypoints;

[_group, _waypoints, 25, "MOVE", "AWARE", "YELLOW", "FULL", "NO CHANGE", "", [1,3,5], 50] call FUNC(waypoints_add);

private _statement = QUOTE(this setVariable [ARR_2('GVAR(state)','finished')]);
[_group, _lastWaypoint, 25, "SAD", "COMBAT", "RED", "FULL", "NO CHANGE", _statement, [3,6,9], 30] call FUNC(waypoints_add);
