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

private _spawnpos = _group getVariable [QGVAR(spawnpos),[0,0,0]];

[_group] call CBA_fnc_clearWaypoints;

private _statement = QUOTE(this setVariable [ARR_2('GVAR(state)','delete')]);
[_group,[_spawnpos],25,"MOVE","CARELESS","BLUE","FULL","NO CHANGE",_statement,[1,3,5],150] call FUNC(waypoints_add);
