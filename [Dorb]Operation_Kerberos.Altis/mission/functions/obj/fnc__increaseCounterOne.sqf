/*
 *  Author: iJesuz
 *
 *  Description:
 *      event called to increase mission's obj_counter_1
 *
 *  Parameter(s):
 *      0 : OBJECT  - mission target
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

if !(isServer) exitWith { -1 };

_this params ["_obj"];

private _mission = _obj getVariable QGVAR(mission);
HASH_SET(_mission, "obj_counter_1", HASH_GET(_mission, "obj_counter_1") + 1);

["COUNTER_1", HASH_GET(_mission, "type"), "green", [name _obj]] call FUNC(obj___createGlobalMessage);
