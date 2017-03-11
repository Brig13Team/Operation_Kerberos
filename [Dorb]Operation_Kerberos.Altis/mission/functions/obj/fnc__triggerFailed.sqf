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

TRACEV_1(_this);

private _mission = _obj getVariable QGVAR(mission);
HASH_SET(_mission, "trigger_failed", true);
HASH_SET(_mission, "event_active", false); // if needed
_obj setVariable [QGVAR(isActive), false, true]; // if needed

["TRIGGER_FAILED", HASH_GET(_mission, "type"), "blue", [name _obj]] call FUNC(obj___createGlobalMessage);
