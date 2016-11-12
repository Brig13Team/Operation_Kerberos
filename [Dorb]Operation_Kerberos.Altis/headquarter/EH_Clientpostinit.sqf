/*
    Author: Dorbedo

    Description:
        postinit client
*/
#include "script_component.hpp"

If (isHeadless) then {
    [
        QGVAR(setVehicleAmmo),
        {
            _this params ["_vehicle",["_ammo",1,[0]]];
            _vehicle setVehicleAmmo 1;
        }
    ] call CBA_fnc_addEventHandler;
};
