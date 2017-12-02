/*
 *  Author: Dorbedo
 *
 *  Description:
 *      postinit Client
 *
 */
#include "script_component.hpp"

CHECK(!hasInterface)

GVAR(lastGroupsToTrack) = [];
GVAR(grouphashes) = [];
GVAR(allMarker) = [];
GVAR(handleID) = -1;
GVAR(showAll) = false; // for debug purpose
// delay the spawn
[
    {[] call FUNC(init);},
    60
] call CBA_fnc_waitAndExecute;

ISNIL(hiddenGroups,[])
