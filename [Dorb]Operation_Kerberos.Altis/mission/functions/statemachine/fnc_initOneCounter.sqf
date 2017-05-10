/*
*  Author: iJesuz, Dorbedo
 *
 *  Description:
 *      Checks the counter
 *
 *  Parameter(s):
 *      0 : LOCATION - the mission
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
TRACE("initOneCounter");
_this params ["_mission"];

private _targets = _mission getVariable ["objects",[]];
HASH_SET(_mission, "obj_counter_total", count _targets);
HASH_SET(_mission, "obj_counter", 0);

HASH_SET(_mission, "trigger_failed", false);
