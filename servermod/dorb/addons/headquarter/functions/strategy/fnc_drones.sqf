/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Attacks a position with drone
 *
 *  Parameter(s):
 *      0 : LOCATION - Attacklocation
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_attackLoc"];
//TRACEV_1(_attackLoc);
private _pos = locationPosition _attackLoc;

private _nearPlayers = allPlayers select {
    ((_x distance _pos)<500) &&
    ((GVARMAIN(side) knowsAbout _x)>1.5) &&
    (!((vehicle _x) isKindOf "Air")) &&
    {side _x == GVARMAIN(playerside)}
};

private _weightArray = [];
{
    _weightArray pushBack [_x, [_x] call FUNC(getCost)];
} forEach _nearPlayers;

private _target = selectRandomWeighted _weightArray;

HASH_SET(_attackLoc,QGVAR(lastAttackRequest),(-1));
TRACEV_2(_target,_attackLoc);

[_target,"dronestrike"] call EFUNC(spawn,offmap_airsupport);

_target;
