/*
 *  Author: iJesuz
 *
 *  Description:
 *      event called to increase mission's obj_counter_2
 *
 *  Parameter(s):
 *      0 : OBJECT / HASH  - mission target
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

if !(isServer) exitWith { -1 };

_this params ["_obj"];
private _mission = _obj;
if ((typeName _obj) isEqualTo "OBJECT") then {
    _obj setVariable [QGVAR(isActive), false, true]; // if needed
    _mission = _obj getVariable QGVAR(mission);
};

HASH_SET(_mission, "obj_counter_2", HASH_GET(_mission, "obj_counter_2") + 1);

[QFUNC(obj___message), ["COUNTER_2", HASH_GET(_mission, "type"), "red", [name _obj]]] call CBA_fnc_globalEvent;
