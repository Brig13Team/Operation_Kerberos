/*
 *  Author: Dorbedo
 *
 *  Description:
 *      preinit
 *
 */
#include "script_component.hpp"

ADDON = false;

PREP(registerSyncData);
PREP(requestData);
PREP(syncDataClient);
PREP(syncDataServer);

ADDON = true;

GVAR(dataToSync) = [];

If (isServer) then {
    GVAR(DataIsSynced) = true;
    [
        QGVAR(requestDataEvent),
        {_this call FUNC(syncData);}
    ] call CBA_fnc_addEventHandler;
} else {
    GVAR(DataIsSynced) = false;
    If (hasInterface) then {
        [{!isNull player},{call FUNC(requestData);}] call CBA_fnc_waitUntilAndExecute;
    }else{
        [{time > 10},{call FUNC(requestData);}] call CBA_fnc_waitUntilAndExecute;
    };
};
