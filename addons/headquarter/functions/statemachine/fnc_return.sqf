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
_group setVariable [QGVAR(state),"returning"];

private _center = HASH_GET(GVAR(dangerzones),"centerpos");

private _targetPos = [_center,400] call EFUNC(common,pos_random);
private _waypoints = [getPos (leader _group),_targetPos] call FUNC(waypoints_generate);

[_group] call CBA_fnc_clearWaypoints;

private _statement = QUOTE(this setVariable [ARR_2('GVAR(state)','combat')]);
[_group,_waypoints,25,"MOVE","AWARE","GREEN","FULL","NO CHANGE",_statement,[1,3,5],150] call FUNC(waypoints_add);
