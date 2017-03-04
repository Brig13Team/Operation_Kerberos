/*
 *  Author: Dorbedo
 *
 *  Description:
 *      suspends the spawning to lower the traffic peaks
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

If ((!canSuspend)||(!isMultiplayer)) exitWith {};

waitUntil {(GVAR(SpawnNext) > CBA_missiontime)};
GVAR(SpawnNext) = CBA_missiontime + 2;
