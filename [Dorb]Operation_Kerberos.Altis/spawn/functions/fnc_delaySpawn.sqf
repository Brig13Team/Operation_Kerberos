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

CHECK(!canSuspend)
CHECK(!isMultiplayer)
ISNIL(SpawnNext,CBA_missiontime);

waitUntil {(GVAR(SpawnNext) < CBA_missiontime)};
GVAR(SpawnNext) = CBA_missiontime + 2;
