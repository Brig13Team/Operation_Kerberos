/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns if a unit has crew when it is spawned
 *
 *  Parameter(s):
 *      0 : OBJECT - the object
 *
 *  Returns:
 *      BOOL - the unit should get a crew
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params ["_object"];

(
    ((count(crew _object)) > 0) ||
    (_object isKindOf "Static")
);
