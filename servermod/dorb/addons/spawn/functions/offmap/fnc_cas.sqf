/**
 * Author: Dorbedo
 * creates a cas attack
 *
 * Arguments:
 * 0: <ARRAY/OBJECT> the target can be an unit or a position
 * 1: <CODE> callback
 *
 * Return Value:
 * nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_target", "_callback"];

private _spawnPos = [[_target] call CBA_fnc_getPos] call FUNC(offmap_getsavespawnposair);












//
