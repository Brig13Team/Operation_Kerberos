/*
 *  Author: Dorbedo, iJesuz
 *
 *  Description:
 *      called after a main mission has ended
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params ["_mission"];

if !(HASH_GET(_mission, "type") isEqualTo "_rtb") exitWith {
    private _location = HASH_GET(_mission, "location");

    GVAR(cleanup_positions) pushback (_location select 1);
};

GVAR(targetHouses) = [];
GVAR(usedHouses) = [];
GVAR(spawnedCompositions) = [];

{
    [_x,2200] call FUNC(cleanup_full);
} forEach GVAR(cleanup_positions);
GVAR(cleanup_positions) = [];
