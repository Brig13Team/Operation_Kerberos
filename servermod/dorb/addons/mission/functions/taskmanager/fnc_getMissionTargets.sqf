/*
 *  Author: iJesuz
 *
 *  Description:
 *      returns an array with all mission targets
 *
 *  Parameter(s):
 *       0 : STRING  - mission name
 *
 *  Returns:
 *      [OBJECT]
 */
#include "script_component.hpp"

_this params [["_name", "", [""]]];

if !THIS_HASKEY(_name) exitWith { [] };

private _mission = THIS_GET(_name);
if !HASH_HASKEY(_mission, "objects") exitWith { [] };

HASH_GET(_mission, "objects")
