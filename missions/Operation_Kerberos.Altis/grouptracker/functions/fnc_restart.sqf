/*
 *  Author: Dorbedo
 *
 *  Description:
 *      restarts the grouptracker
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

{
    deleteMarkerLocal _x
} forEach GVAR(allMarker);
GVAR(allMarker) = [];

{
    private _groupHash = _x getVariable QGVAR(groupHash);
    If !(isNil "_groupHash") then {
        HASH_DELETE(_groupHash);
        _x setVariable [QGVAR(groupHash),locationNull];
    };
} forEach allGroups;

GVAR(grouphashes) = [];
