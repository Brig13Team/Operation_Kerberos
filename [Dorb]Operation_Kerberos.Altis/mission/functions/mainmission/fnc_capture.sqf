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


private _objects = [_position,"capture",_amount] call EFUNC(spawn,createMissionTarget);

private _hash = HASH_CREATE;
GVAR(mission_commander) = _hash;

{
    _x setVariable [QGVAR(missionHash),_hash];
    _x setVariable [QGVAR(rescueEvent),QGVAR(commander_captured)];
} forEach _objects;

{
    _x setVariable [QGVAR(rescueEvent),QGVAR(commander_captured)];
    _x addEventHandler ["Killed", LINKFUNC(onCommanderKilled)];
} forEach _objects;


// Init for Conditional Function
GVAR(commander_captured) = 0;
GVAR(commander_killed) = 0;

[QFUNC(mainmission_capture_cond),[_objects,_amount]]
