/**
 * Author: Dorbedo
 * unload event
 *
 * Arguments:
 * 0: <DISPLAY> the display
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

params ["_display"];

GVAR(curList) = HASH_CREATE;
