/**
 * Author: Dorbedo
 * the minefield side mission
 *
 * Arguments:
 * 0: <ARRAY> the centerposition
 * 1: <LOCATION> the missionHash
 *
 * Return Value:
 * Nothing
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_centerpos","_mission"];

[_centerpos,150,0,60] call EFUNC(spawn,spawnMinefieldACE);

_mission setVariable ["list",{allMines}];
TRACEV_2(_centerpos,allMines);
allMines select {(_x distance2D _centerpos)<320};
