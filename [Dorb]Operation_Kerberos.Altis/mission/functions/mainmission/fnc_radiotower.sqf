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

_this params [["_destination",["",[0,0,0]],[["",[]]]]];

private _min = getArray(missionConfigFile >> "missions_config" >> "main" >> "radiotower" >> "objectsamount_min");
private _max = getArray(missionConfigFile >> "missions_config" >> "main" >> "radiotower" >> "objectsamount_max");
private _amount = (floor random (_max - _min + 1)) + _min;

private _position = _destination select 1;
private _radius = getNumber(missionConfigFile >> "missions_config" >> "main" >> "radiotower" >> "location" >> "distance");

private _objects = [_position,"radiotower",[_radius,_amount]] call EFUNC(spawn,spawnMissionTarget);

{
    _x setdamage 0;
    _unit setVariable [GVAR(isAlive),true];
    _x addEventHandler ["HandleDamage", LINKFUNC(objects_onHandleDamageC4)];
} forEach _objects;

GVAR(tower_destroyed) = 0;

[QFUNC(mainmission_radiotower_cond),_objects]
