/*
 *  Author: iJesuz
 *
 *  Description:
 *      condition with one counters
 *      (can be used for sidemission too)
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *
 *  Returns:
 *      STRING
 */
#include "script_component.hpp"

_this params ["_mission"];

// one did something very bad...
private _fail = HASH_GET(_mission, "trigger_failed");
if (_fail) exitWith { "Failed" };

// time is just over
private _tte = HASH_GET(_mission, "time_to_end");
if ((_tte > 0) && {CBA_missiontime >= _tte}) exitWith { "Failed" };

// just normal end condition
private _counter_total = HASH_GET(_mission, "obj_counter_total");
private _counter       = HASH_GET(_mission, "obj_counter");
if (_counter >= _counter_total) exitWith { "Succeeded" };

""
