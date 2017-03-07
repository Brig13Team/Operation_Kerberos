/*
 *  (old file)
 *
 *  Author: Dorbedo
 *
 *  Description:
 *      Checks if units are alive
 *
 *  Parameter(s):
 *      0 : ARRAY - Targets
 *
 *  Returns:
 *      STRING - taskstate
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_targets",[],[[],objNull]]];

If (IS_OBJECT(_targets)) then {_targets = [_targets];};

private _living_targets = {
    (alive _x)||
    (_x getVariable[QGVAR(isAlive),true])
} count _targets;

If (_living_targets < 1) exitWith { "Succeeded" };
""
