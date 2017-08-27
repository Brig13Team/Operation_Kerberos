/**
 * Author: Dorbedo
 * mission airsuperiority
 *
 * Arguments:
 * 0: <LOCATION> mission
 * 1: <ARRAY> the mission objects
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_mission", "_targets"];

{
    _x addEventHandler ["Killed", LINKFUNC(obj__increaseCounter)];
} forEach _targets;
