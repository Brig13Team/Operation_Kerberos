/*
    Author: Dorbedo
    
    Description:
        initialization for logistics
*/
#include "script_component.hpp"

[
    QGVAR(updateSeats_Vehicle),
    {
        If (local (_this select 0)) then {
            [_this select 0] call FUNC(updateSeats);
        };
    }
] call EFUNC(events,addEventHandler);