/*
 * Copied from ACEX (https://github.com/acemod/ACEX)
 *
 */

#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;
#include "XEH_PREP.hpp"
RECOMPILE_END;

GVAR(enabled) = true;
GVAR(delay) = HEADLESSDELAY;
GVAR(log) = true;

if (isServer) then {
    GVAR(headlessClients) = [];
    GVAR(inRebalance) = false;
    GVAR(endMissionCheckDelayed) = false;
    [QGVAR(headlessClientJoined), FUNC(handleConnectHC)] call CBA_fnc_addEventHandler;
};


ADDON = true;


["cba_settingsInitialized", {
    // Register and remove HCs if not client that is not server and distribution or end mission enabled
    if (((!hasInterface) || isServer) && {GVAR(enabled)}) then {
        if (isServer) then {
            // Request rebalance on any unit spawn (only if distribution enabled)
            if (GVAR(enabled)) then {
                ["AllVehicles", "init", FUNC(handleSpawn), nil, nil, true] call CBA_fnc_addClassEventHandler;
            };
            // Add disconnect EH
            addMissionEventHandler ["HandleDisconnect", {call FUNC(handleDisconnect)}];
        } else {
            // Register HC (this part happens on HC only)
            [QGVAR(headlessClientJoined), [player]] call CBA_fnc_globalEvent; // Global event for API purposes
        };
    };
}] call CBA_fnc_addEventHandler;
