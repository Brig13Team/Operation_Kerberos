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
            _vehicle setVehicleAmmo _ammo;
        }
    ] call CBA_fnc_addEventHandler;
};

// DEBUG
GVAR(debugMarkerActive) = false;
#ifdef DEBUG_MODE_FULL
    GVAR(debugMarkerActive) = true;
    [LINKFUNCFUNC(handleDebugMarker),60,[]] call CBA_fnc_addPerFrameHandler;
#endif
