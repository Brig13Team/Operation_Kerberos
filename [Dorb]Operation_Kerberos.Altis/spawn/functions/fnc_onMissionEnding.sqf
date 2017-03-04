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

if !(HASH_GET(_mission, "type") isEqualTo "_rtb") exitWith { -1 };

private _centerpos = HASH_GET(_mission,"location") select 1;

GVAR(targetHouses) = [];
GVAR(usedHouses) = [];
GVAR(spawnedCompositions) = [];

[_centerpos,2200] call FUNC(cleanup_full);
