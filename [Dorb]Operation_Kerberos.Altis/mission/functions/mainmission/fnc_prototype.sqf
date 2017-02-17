/*
 * (old file)
 *
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

_this params [["_destination","",[""]],["_position",[],[[]]]];

private _min = getNumber(missionConfigFile >> "missions_config" >> "main" >> "prototype" >> "objectsamount_min");
private _max = getNumber(missionConfigFile >> "missions_config" >> "main" >> "prototype" >> "objectsamount_max");
TRACEV_4(_max,_min,_destination,_position);
private _amount = (floor (random ((_max - _min) + 1))) + _min;


private _radius = getNumber(missionConfigFile >> "missions_config" >> "main" >> "prototype" >> "location" >> "distance");

private _objects = [_position,"prototype",[_radius,_amount]] call EFUNC(spawn,createMissionTarget);

{
    _x setVariable [QGVAR(rescueEvent),QGVAR(prototype_rescued)];
    _x addEventHandler ["Killed",LINKFUNC(onPrototypeKilled)];
} forEach _objects;



GVAR(rescued_prototype) = 0;
GVAR(killed_prototype) = 0;

[QFUNC(mainmission_prototype_cond),[count _objects]]
