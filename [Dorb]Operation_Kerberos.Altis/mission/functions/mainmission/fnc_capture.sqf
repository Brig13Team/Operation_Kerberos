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

_this params [["_destination","",[""]],["_position",[],[[]]]];

private _min = getNumber(missionConfigFile >> "missions_config" >> "main" >> "capture" >> "objectsamount_min");
private _max = getNumber(missionConfigFile >> "missions_config" >> "main" >> "capture" >> "objectsamount_max");
TRACEV_4(_max,_min,_destination,_position);
private _amount = (floor (random ((_max - _min) + 1))) + _min;


private _objects = [_position,"capture",_comander_avg] call EFUNC(spawn,createMissionTarget);

// Init for Conditional Function
GVAR(commander_captured) = 0;
GVAR(commander_killed) = 0;

[QFUNC(mainmission_capture_cond),[_comander_avg]]
