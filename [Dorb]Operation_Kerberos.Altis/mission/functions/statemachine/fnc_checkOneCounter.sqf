/*
 *  Author: iJesuz, Dorbedo
 *
 *  Description:
 *      Checks the counter
 *
 *  Parameter(s):
 *      0 : LOCATION - the mission
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_mission"];

if (HASH_HASKEY(_mission, "event_callback")) then {
    private _event = HASH_GET(_mission, "event_callback");
    [_mission] spawn (missionNamespace getVariable [_event, {}]);
};


// one did something very bad...
private _fail = HASH_GET(_mission, "trigger_failed");
if (_fail) exitWith {
    _mission setVariable ["progress","failed"];
};

// just normal end condition
private _counter_total = HASH_GET(_mission, "obj_counter_total");
private _counter       = HASH_GET(_mission, "obj_counter");
if (_counter >= _counter_total) exitWith {
    _mission setVariable ["progress","succeeded"];
};
