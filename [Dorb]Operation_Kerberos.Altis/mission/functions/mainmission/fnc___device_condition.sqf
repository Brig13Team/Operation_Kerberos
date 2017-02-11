/*
 *  Author: iJesuz
 *
 *  Description:
 *      condition for device
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *
 *  Returns:
 *      STRING
 */
#include "script_component.hpp"

_this params ["_mission"];

private _obj = HASH_GET(_mission, "object");

if (isNil "_obj") exitWith { "Canceled" };
if (isNull _obj) exitWith { "Canceled" };

// check mission
if !(_obj getVariable [QGVAR(isActive), true]) exitWith { "Succeeded" };
if (!(alive _obj)) exitWith { "Failed" };

""
