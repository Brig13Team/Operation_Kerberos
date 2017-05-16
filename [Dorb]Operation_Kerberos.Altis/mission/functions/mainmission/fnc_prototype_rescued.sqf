/*
 *  Author: DOrbedo
 *
 *  Description:
 *      the recue Event
 *
 *  Parameter(s):
 *      0 : OBJECT - the prototype
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_object"];

[typeOf _object] spawn FUNC(spawn_createAtRescuePoint);
_this call FUNC(obj__increaseCounter);
