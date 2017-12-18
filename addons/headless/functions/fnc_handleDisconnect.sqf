/*
 * Copied from ACEX (https://github.com/acemod/ACEX)
 *
 * Author: Jonpas
 * Removes Headless Client from use.
 * Ends mission if setting enabled and only Headless CLients are still connected.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * Transfer To Server <BOOL>
 *
 * Example:
 * [unit] call acex_headless_fnc_handleDisconnect
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_object"];
TRACE_1("HandleDisconnect",_this);

// Exit if not HC
if !(_object in GVAR(headlessClients)) exitWith {
    TRACE_2("Object not in HC list",_object,GVAR(headlessClients));
    false
};

// Exit if AI distribution is disabled but end mission is enabled
if (!GVAR(enabled)) exitWith {true};

// Remove HC
GVAR(headlessClients) deleteAt (GVAR(headlessClients) find _object);

if (GVAR(log)) then {
    INFO_1("Removed HC: %1",_object);
};

// Rebalance
[true] call FUNC(rebalance);

// Prevent transferring of HC to server
false
