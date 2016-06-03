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