/*
 *  Author: iJesuz
 *
 *  Description:
 *      condition with two counters
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *
 *  Returns:
 *      STRING
 */
#include "script_component.hpp"

_this params ["_mission"];

private _objs = HASH_GET(_mission, "objects");

if (({ alive _x } count _objs) > 0) exitWith { "" };

private _c    = HASH_GET(_mission, "obj_counter_total");
private _c1   = HASH_GET(_mission, "obj_counter_1");
private _c2   = HASH_GET(_mission, "obj_counter_2");

if (_c1 >  floor((_c * 2) / 3)) exitWith { "Succeeded" };
if (_c2 >= floor((_c * 2) / 3)) exitWith { "Failed" };

"Canceled"
