/*
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

_this params [["_destination",["",[0,0,0]],[["",[]]]]];

private _position = _destination select 1;
private _radius = getNumber(missionConfigFile >> "missions_config" >> "main" >> "scarab" >> "location" >> "distance");

private _objects = [_position,"scarab",_radius] call EFUNC(spawn,spawnMissionTarget);



{
    _x addEventHandler ["Killed", {
        [getPos _x] call FUNC(objects_nuke);
    }];
} forEach _objects;


GVAR(scarab_timer) = CBA_missionTime + 60 * 60;
GVAR(scarab_waiting) = true;

[QFUNC(mainmission_scarab_cond),[_objects]]
