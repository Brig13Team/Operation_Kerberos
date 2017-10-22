/**
 * Author: Dorbedo
 * Checks if the units have been RTB
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * <BOOL> all Units are in their respawn locations
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _allPlayers = ([] call CBA_fnc_players) select {alive _x};

(({
    private _curPlayer = _x;
    (({
        (_x distance2D _curPlayer)<200
    } count (GVAR(allRespawnMarkerLocations) select ([side _curPlayer] call BIS_fnc_sideID))) isEqualTo 0)
} count _allPlayers) isEqualTo 0)
