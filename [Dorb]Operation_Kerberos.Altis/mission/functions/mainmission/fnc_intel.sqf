/*
    Author: iJesuz

    Description:
        Mission "Intel"

    Parameter(s):
        0 : [STRING,ARRAY]  - Destination [Locationname, Position]

    Return:
        [CODE,ARRAY]    -   [Taskhandler conditional function, its arguments]
*/
#include "script_component.hpp"

_this params [["_destination",["",[0,0,0]],[["",[]]]]];

private _min = getArray(missionConfigFile >> "missions_config" >> "main" >> "intel" >> "objectsamount_min");
private _max = getArray(missionConfigFile >> "missions_config" >> "main" >> "intel" >> "objectsamount_max");
private _amount = (floor random (_max - _min + 1)) + _min;

private _position = _destination select 1;
private _intel = [_position,"intel",_amount] call EFUNC(spawn,spawnMissionTarget);

{
    _x setVariable [QGVAR(rescueEvent),QGVAR(intel_found)];
} forEach _intel;


// Init for Conditional Function
GVAR(found_intel) = 0;

[QFUNC(mainmission_intel_cond),[_amount]]
