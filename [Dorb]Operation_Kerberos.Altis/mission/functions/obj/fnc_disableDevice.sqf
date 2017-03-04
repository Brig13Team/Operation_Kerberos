/*
 *  Author: iJesuz
 *
 *  Description:
 *      disable device and event
 *
 *  Parameter(s):
 *      0 : OBJECT  - device/emp
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_device"];

_device setVariable [QGVAR(isActive), false, true];

private _mission = _device getVariable QGVAR(mission);
HASH_SET(_mission, "event_active", false);
HASH_SET(_mission, "obj_counter", HASH_GET(_mission, "obj_counter") + 1);
