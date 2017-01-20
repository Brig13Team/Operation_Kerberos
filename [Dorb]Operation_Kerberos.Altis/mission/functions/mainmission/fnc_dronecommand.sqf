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

_this params [["_destination",["",[0,0,0]],[["",[]]]]];

private _min = getArray(missionConfigFile >> "missions_config" >> "main" >> "dronecommando" >> "objectsamount_min");
private _max = getArray(missionConfigFile >> "missions_config" >> "main" >> "dronecommando" >> "objectsamount_max");
private _amount = (floor random (_max - _min + 1)) + _min;

private _position = _destination select 1;
private _radius = getNumber(missionConfigFile >> "missions_config" >> "main" >> "dronecommando" >> "location" >> "distance");

private _objects = [_position,"dronecommando",[_radius,_amount]] call EFUNC(spawn,spawnMissionTarget);

GVAR(tower_destroyed) = 0;

[QFUNC(mainmission_dronecommando_cond),_objects]
