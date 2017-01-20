/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Mission "Capture"
 *
 *  Parameter(s):
 *      0 : [STRING,ARRAY] - Destination [Locationname, Position]
 *
 *  Returns:
 *      [CODE,ARRAY] - [Taskhandler conditional function, its arguments]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_destination",["",[0,0,0]],[["",[]]]]];

private _min = getArray(missionConfigFile >> "missions_config" >> "main" >> "capture" >> "objectsamount_min");
private _max = getArray(missionConfigFile >> "missions_config" >> "main" >> "capture" >> "objectsamount_max");

private _amount = (floor random (_max - _min + 1)) + _min;

private _position = _destination select 1;
private _objects = [_position,"capture",_comander_avg] call EFUNC(spawn,spawnMissionTarget);

// Init for Conditional Function
GVAR(commander_captured) = 0;
GVAR(commander_killed) = 0;

[QFUNC(mainmission_capture_cond),[_comander_avg]]
