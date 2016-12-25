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

GVAR(Intervall) = 5; // Intervall of refreshing the grouptracker
GVAR(delayAmount) = 3; // Amount of old positions to be displayed before the current one
/*
 *    If you set the intervall to 5 and the delayAmount to 3, the grouptracker only shows the positions 15 secondes before
 *
 */
GVAR(showAI) = true; // shows Groups witch are not led by a player


// Initializing
GVAR(active) = false;
GVAR(lastGroupsToTrack) = [];
GVAR(grouphashes) = [];
GVAR(allMarker) = [];

// delay the spawn
[
    {[] call FUNC(init);},
    60
] call CBA_fnc_waitAndExecute;
