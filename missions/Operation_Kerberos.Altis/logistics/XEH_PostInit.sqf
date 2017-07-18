/*
    Author: Dorbedo

    Description:
        initialization for logistics
*/
#include "script_component.hpp"

[
    QGVAR(updateSeats_Vehicle),
    {
        _this params ["_vehicle"];
        If (local _vehicle) then {
            [_vehicle] call FUNC(updateSeats);
        };
    }
] call CBA_fnc_addEventHandler;

[
    QGVAR(setContainerWeight),
    {
        _this call FUNC(setContainerWeight);
    }
] call CBA_fnc_addEventHandler;

[
    QGVAR(enableCollision),
    {
        params ["_vehicle","_cargo"];
        _vehicle enableCollisionWith _cargo;
    }
] call CBA_fnc_addEventHandler;

[
    QGVAR(disableCollision),
    {
        params ["_vehicle","_cargo"];
        _vehicle disableCollisionWith _cargo;
    }
] call CBA_fnc_addEventHandler;
