#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.sqf"

ADDON = true;

If (isServer) then {
    // it can happen, that this is running before it's secure to retreive the respawnmarkerposition
    [
        {
            (!isNil QGVARMAIN(respawnmarker))&&
            {!((getMarkerPos GVARMAIN(respawnmarker)) isEqualTo [0,0,0])}
        },
        LINKFUNC(initialize),
        [],
        300
    ] call CBA_fnc_waitUntilAndExecute;
};
