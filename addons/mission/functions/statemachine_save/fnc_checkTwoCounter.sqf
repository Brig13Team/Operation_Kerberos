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


private _objs = HASH_GET(_mission, "objects");

if (({ alive _x } count _objs) > 0) exitWith {};

private _c    = HASH_GET(_mission, "obj_counter_total");
private _c1   = HASH_GET(_mission, "obj_counter_1");
private _c2   = HASH_GET(_mission, "obj_counter_2");

if (_c1 >  floor((_c * 2) / 3)) exitWith {
    _mission setVariable ["progress","succeeded"];
};
if (_c2 >= floor((_c * 2) / 3)) exitWith {
    _mission setVariable ["progress","failed"];
};
_mission setVariable ["progress","neutral"];
