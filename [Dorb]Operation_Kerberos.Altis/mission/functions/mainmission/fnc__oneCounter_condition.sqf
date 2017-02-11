/*
 *  Author: iJesuz
 *
 *  Description:
 *      condition with one counters
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *
 *  Returns:
 *      STRING
 */
#include "script_component.hpp"

_this params ["_mission"];

private _counter_total = HASH_GET(_mission, "obj_counter_total");
private _counter       = HASH_GET(_mission, "obj_counter");

if (_counter >= _counter_total) exitWith { "Succeeded" };

""
