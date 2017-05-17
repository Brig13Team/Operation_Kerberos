/*
 *  Author: iJesuz
 *
 *  Description:
 *      event called to increase mission's obj_counter
 *
 *  Parameter(s):
 *      0 : OBJECT / HASH  - mission target
 *
 *  Returns:
 *      -
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

if !(isServer) exitWith { -1 };

_this params ["_obj"];
private _mission = _obj;
TRACEV_1(_this);
if ((typeName _obj) isEqualTo "OBJECT") then {
    _obj setVariable [QGVAR(isActive), false, true]; // if needed
    _mission = _obj getVariable QGVAR(mission);
};

HASH_SET(_mission, "obj_counter", HASH_GET(_mission, "obj_counter") + 1);
HASH_SET(_mission, "event_active", false); // if needed

[QFUNC(obj___message), ["COUNTER", HASH_GET(_mission, "type"), "green", [name _obj]]] call CBA_fnc_globalEvent;
