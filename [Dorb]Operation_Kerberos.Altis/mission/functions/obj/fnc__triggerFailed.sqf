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
#include "script_component.hpp"

if !(isServer) exitWith { -1 };

_this params ["_obj"];
private _mission = _obj;
if ((typeName _obj) isEqualTo "OBJECT") then {
    _obj setVariable [QGVAR(isActive), false, true]; // if needed
    _mission = _obj getVariable QGVAR(mission);
};

HASH_SET(_mission, "trigger_failed", true);
HASH_SET(_mission, "event_active", false); // if needed

[QFUNC(obj___message), ["TRIGGER_FAILED", HASH_GET(_mission, "type"), "blue", [name _obj]]] call CBA_fnc_globalEvent;
