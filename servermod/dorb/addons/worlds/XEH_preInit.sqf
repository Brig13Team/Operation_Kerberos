#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

ADDON = true;

GVAR(isInitialized) = false;

If (isServer) then {
    // it can happen, that this is running before it's secure to retreive the respawnmarkerposition
    [
        {
            (!isNil QGVARMAIN(respawnmarker))&&
            {!(([GVARMAIN(playerside)] call EFUNC(common,getRespawnPos)) isEqualTo [])}
        },
        LINKFUNC(initialize),
        [],
        300
    ] call CBA_fnc_waitUntilAndExecute;
};
