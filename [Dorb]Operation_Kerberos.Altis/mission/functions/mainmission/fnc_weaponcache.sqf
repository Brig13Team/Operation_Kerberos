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

_this params [["_destination",["",[0,0,0]],[["",[]]]]];

private _min = getArray(missionConfigFile >> "missions_config" >> "main" >> "weaponcache" >> "objectsamount_min");
private _max = getArray(missionConfigFile >> "missions_config" >> "main" >> "weaponcache" >> "objectsamount_max");
private _amount = (floor random (_max - _min + 1)) + _min;

private _position = _destination select 1;
private _wpnCaches = [_position,"weaponcache",_amount] call EFUNC(spawn,spawnMissionTarget);
{
    _x addEventHandler ["Killed",{
            _this params ["_unit","_killer"];

            "Bo_Mk82" createVehicle (getPos _unit);
            [QGVAR(weaponcache_destroyed),[_unit]] call CBA_fnc_globalEvent;
    }]
} forEach _wpnCaches;

// Init for Conditional Function
GVAR(destroyed_caches) = 0;

[QFUNC(mainmission_weaponcache_cond),[_amount]]
