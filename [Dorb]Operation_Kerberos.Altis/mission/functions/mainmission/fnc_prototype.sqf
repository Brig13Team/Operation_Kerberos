/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Mission "prototype"
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

private _min = getArray(missionConfigFile >> "missions_config" >> "main" >> "prototype" >> "objectsamount_min");
private _max = getArray(missionConfigFile >> "missions_config" >> "main" >> "prototype" >> "objectsamount_max");
private _amount = (floor random (_max - _min + 1)) + _min;

private _position = _destination select 1;
private _radius = getNumber(missionConfigFile >> "missions_config" >> "main" >> "prototype" >> "location" >> "distance");

private _objects = [_position,"prototype",[_radius,_amount]] call EFUNC(spawn,spawnMissionTarget);

{
    _x setVariable [QGVAR(rescueEvent),QGVAR(prototype_rescued)];
    _x addEventHandler ["Killed",LINKFUNC(onPrototypeKilled)];
} forEach _objects;



GVAR(rescued_prototype) = 0;
GVAR(killed_prototype) = 0;

[QFUNC(mainmission_prototype_cond),_objects]
