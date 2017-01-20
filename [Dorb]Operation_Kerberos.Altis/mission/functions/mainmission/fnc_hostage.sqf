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

_this params [["_destination",["",[0,0,0]],[["",[]]]]];

private _min = getArray(missionConfigFile >> "missions_config" >> "main" >> "hostage" >> "objectsamount_min");
private _max = getArray(missionConfigFile >> "missions_config" >> "main" >> "hostage" >> "objectsamount_max");
private _amount = (floor random (_max - _min + 1)) + _min;

[_position,"hostage",_radius] call EFUNC(spawn,spawnMissionTarget);

// Init for Conditional Function
GVAR(rescued_hostages) = 0;
GVAR(killed_hostages) = 0;

[QFUNC(mainmission_hostage_cond),[_amount]]
