/*
 * (old file)
 *
 *  Author: Dorbedo
 *
 *  Description:
 *      Mission Specops
 *
 *  Parameter(s):
 *      0 : [STRING,ARRAY]  - Destination [Locationname, Position]
 *
 *  Returns:
 *      [CODE,ARRAY] - [Taskhandler conditional function, its arguments]
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_destination","",[""]],["_position",[],[[]]]];

private _distance = getNumber(missionConfigFile >> "missions_config" >> "main" >> "specops" >> "location" >> "distance");
TRACEV_3(_destination,_position,_distance);
[_position,"Specops",_distance] call EFUNC(spawn,createMissionTarget);

private _clearradius = getNumber(missionConfigFile >> "missions_config" >> "main" >> "specops" >> "radius");
private _unitamount = getNumber(missionConfigFile >> "missions_config" >> "main" >> "specops" >> "unitamount");

[QFUNC(mainmission_Specops_cond),[_position,_clearradius,_unitamount]];
