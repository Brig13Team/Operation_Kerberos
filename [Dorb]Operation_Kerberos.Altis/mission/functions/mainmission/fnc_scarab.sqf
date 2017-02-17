/*
 * (old file)
 *
 *  Author: Dorbedo
 *
 *  Description:
 *      Mission "SCARAB"
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

private _radius = getNumber(missionConfigFile >> "missions_config" >> "main" >> "scarab" >> "location" >> "distance");

private _objects = [_position,"scarab",_radius] call EFUNC(spawn,createMissionTarget);

{
    _x addEventHandler ["Killed", {[getPos (_this select 0)] call FUNC(objects_nuke);}];
} forEach _objects;

GVAR(scarab_timer) = CBA_missionTime + 60 * 60;
GVAR(scarab_waiting) = true;
If !(IS_ARRAY(_objects)) then {_objects = [_objects]};
[QFUNC(mainmission_scarab_cond),_objects]
