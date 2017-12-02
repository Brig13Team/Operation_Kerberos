/*
 *  Author: Dorbedo
 *
 *  Description:
 *      postinit Client
 *
 */
#include "script_component.hpp"

CHECK(!hasInterface)

// Settings

ISNIL(Intervall,5); // Intervall of refreshing the grouptracker
ISNIL(delayAmount,3); // Amount of old positions to be displayed before the current one
/*
 *    If you set the intervall to 5 and the delayAmount to 3, the grouptracker only shows the positions 15 secondes before
 *
 */
ISNIL(AiIsVisible,true); // shows Groups witch are not led by a player


// Initializing
GVAR(active) = true;
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
