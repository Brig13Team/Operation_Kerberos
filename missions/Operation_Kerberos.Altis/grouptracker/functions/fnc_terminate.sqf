/*
 *  Author: Dorbedo
 *
 *  Description:
 *      terminates the grouptracker
 *
 *  Parameter(s):
 *      0 : STRING - handlerID
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params ["_handler"];

GVAR(active) = false;

[GVAR(handler)] call CBA_fnc_removePerFrameHandler;

GVAR(handler) = nil;

{
    deleteMarkerLocal _x
} forEach GVAR(allMarker);
GVAR(allMarker) = [];
