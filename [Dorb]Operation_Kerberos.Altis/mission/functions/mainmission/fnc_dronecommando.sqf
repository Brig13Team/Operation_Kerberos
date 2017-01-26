/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Mission "dronecommando"
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

private _min = getNumber(missionConfigFile >> "missions_config" >> "main" >> "dronecommando" >> "objectsamount_min");
private _max = getNumber(missionConfigFile >> "missions_config" >> "main" >> "dronecommando" >> "objectsamount_max");
TRACEV_4(_max,_min,_destination,_position);
private _amount = (floor (random ((_max - _min) + 1))) + _min;


private _radius = getNumber(missionConfigFile >> "missions_config" >> "main" >> "dronecommando" >> "location" >> "distance");

private _objects = [_position,"dronecommando",[_radius,_amount]] call EFUNC(spawn,createMissionTarget);

GVAR(tower_destroyed) = 0;

[QFUNC(mainmission_dronecommando_cond),_objects]
