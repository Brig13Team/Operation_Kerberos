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
    private _groupHash = _x getVariable QGVAR(grouphash);
    if !(isNil "_groupHash") then {
        [_groupHash] call FUNC(deleteMarker);
    };
} forEach allGroups;
