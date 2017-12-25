/*
*  Author: iJesuz, Dorbedo
 *
 *  Description:
*      initializes a two counter
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

_this params ["_mission"];


private _targets = _mission getVariable ["objects",[]];
HASH_SET(_mission, "obj_counter_total", count _targets);
HASH_SET(_mission, "obj_counter_1", 0); // _event_1's counter
HASH_SET(_mission, "obj_counter_2", 0); // _event_2's counter
