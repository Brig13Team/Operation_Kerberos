/*
    Author: iJesuz

    Description:
        Mission "Hostage"

    Parameter(s):
        0 : [STRING,ARRAY]  - Destination [Locationname, Position]
<
    Return:
        [CODE,ARRAY]    -   [Taskhandler conditional function, its arguments]
*/
#include "script_component.hpp"

_this params [["_destination","",[""]],["_position",[],[[]]]];

private _min = getNumber(missionConfigFile >> "missions_config" >> "main" >> "hostage" >> "objectsamount_min");
private _max = getNumber(missionConfigFile >> "missions_config" >> "main" >> "hostage" >> "objectsamount_max");
TRACEV_4(_max,_min,_destination,_position);
private _amount = (floor (random ((_max - _min) + 1))) + _min;

private _hostages = [_position,"hostage",[_amount,_radius]] call EFUNC(spawn,createMissionTarget);
{
    _x setVariable [QGVAR(rescueEvent),QGVAR(hostage_rescued)];
    _x addEventHandler ["Killed", LINKFUNC(onHostageKilled)];
} forEach _hostages;

// Init for Conditional Function
GVAR(rescued_hostages) = 0;
GVAR(killed_hostages) = 0;

[QFUNC(mainmission_hostage_cond),[_amount]]
