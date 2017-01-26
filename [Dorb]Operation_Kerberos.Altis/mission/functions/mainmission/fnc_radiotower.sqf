/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Mission "radiotower"
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

private _min = getNumber(missionConfigFile >> "missions_config" >> "main" >> "radiotower" >> "objectsamount_min");
private _max = getNumber(missionConfigFile >> "missions_config" >> "main" >> "radiotower" >> "objectsamount_max");
TRACEV_4(_max,_min,_destination,_position);
private _amount = (floor (random ((_max - _min) + 1))) + _min;


private _radius = getNumber(missionConfigFile >> "missions_config" >> "main" >> "radiotower" >> "location" >> "distance");

private _objects = [_position,"radiotower",[_radius,_amount]] call EFUNC(spawn,createMissionTarget);

{
    _x setdamage 0;
    _unit setVariable [GVAR(isAlive),true];
    _x addEventHandler ["HandleDamage", LINKFUNC(objects_onHandleDamageC4)];
} forEach _objects;

GVAR(tower_destroyed) = 0;

[QFUNC(mainmission_radiotower_cond),_objects]
