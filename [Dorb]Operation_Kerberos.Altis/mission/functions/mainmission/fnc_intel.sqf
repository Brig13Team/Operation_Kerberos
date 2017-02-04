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

_this params [["_destination","",[""]],["_position",[],[[]]]];

private _min = getNumber(missionConfigFile >> "missions_config" >> "main" >> "intel" >> "objectsamount_min");
private _max = getNumber(missionConfigFile >> "missions_config" >> "main" >> "intel" >> "objectsamount_max");
TRACEV_4(_max,_min,_destination,_position);
private _amount = (floor (random ((_max - _min) + 1))) + _min;


private _intel = [_position,"intel",_amount] call EFUNC(spawn,createMissionTarget);

_amount = 0;
{
    _x setVariable [QGVAR(rescueEvent),QGVAR(intel_found)];
    _amount = _amount + 1;
} forEach _intel;


// Init for Conditional Function
GVAR(found_intel) = 0;

[QFUNC(mainmission_intel_cond),[_amount]]
