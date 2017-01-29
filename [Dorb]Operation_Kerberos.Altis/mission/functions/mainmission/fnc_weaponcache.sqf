/*
    Author: iJesuz

    Description:
        Mission "Weaponcache"

    Parameter(s):
        0 : [STRING,ARRAY]  - Destination [Locationname, Position]

    Return:
        [CODE,ARRAY]    -   [Taskhandler conditional function, its arguments]
*/
#include "script_component.hpp"

_this params [["_destination","",[""]],["_position",[],[[]]]];

private _min = getNumber(missionConfigFile >> "missions_config" >> "main" >> "weaponcache" >> "objectsamount_min");
private _max = getNumber(missionConfigFile >> "missions_config" >> "main" >> "weaponcache" >> "objectsamount_max");
TRACEV_4(_max,_min,_destination,_position);
private _amount = (floor (random ((_max - _min) + 1))) + _min;


private _wpnCaches = [_position,"weaponcache",_amount] call EFUNC(spawn,createMissionTarget);
{
    _x addEventHandler ["Killed",{
            _this params ["_unit","_killer"];
            [QGVAR(weaponcache_destroyed),[_unit]] call CBA_fnc_globalEvent;
    }]
} forEach _wpnCaches;

// Init for Conditional Function
GVAR(destroyed_caches) = 0;

[QFUNC(mainmission_weaponcache_cond),[_amount]]