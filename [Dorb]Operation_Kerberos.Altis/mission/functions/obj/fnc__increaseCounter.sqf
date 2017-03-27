/*
 *  Author: iJesuz
 *
 *  Description:
 *      event called to increase mission's obj_counter
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

_obj setVariable [QGVAR(isActive), false, true]; // if needed
HASH_SET(_mission, "obj_counter", HASH_GET(_mission, "obj_counter") + 1);
HASH_SET(_mission, "event_active", false); // if needed

if HASH_GET_DEF(_mission, "no_message", false) then {
    [QFUNC(obj___message), ["COUNTER", HASH_GET(_mission, "type"), "green", [name _obj]]] call CBA_fnc_globalEvent;
};
