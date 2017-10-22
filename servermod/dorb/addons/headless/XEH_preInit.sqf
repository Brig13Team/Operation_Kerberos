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
