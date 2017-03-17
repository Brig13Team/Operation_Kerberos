/*
 *  Author: Dorbedo
 *
 *  Description:
 *      requests the data from Server
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
#include "script_component.hpp"

GVAR(dataSyncStart) = diag_tickTime;

[
    {GVAR(DataIsSynced)},
    {
        diag_log text format["[Mission] Data received: %1KB (%2s)",(count(toArray(str GVAR(syncData))))/1024,diag_tickTime-GVAR(dataSyncStart)];
    }
] call CBA_fnc_waitUntilAndExecute;
[QGVAR(requestDataEvent),[player]] call CBA_fnc_serverEvent;
