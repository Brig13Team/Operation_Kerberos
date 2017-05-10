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

GVAR(cleaningUp) = true;

if !( HASH_GET_DEF(_mission, "type","none") == "rtb") exitWith {
    private _location = HASH_GET(_mission, "location");
    GVAR(cleanup_positions) pushback (_location select 1);
    [] call FUNC(Army_set);
};

GVAR(cleanup_positions) = GVAR(cleanup_positions) + (missionNamespace getVariable [QGVAR(rescuepositions),[]]);

GVAR(targetHouses) = [];
GVAR(usedHouses) = [];
GVAR(spawnedCompositions) = [];

{
    [_x,2200] call FUNC(cleanup_full);
} forEach GVAR(cleanup_positions);
GVAR(cleanup_positions) = [];
