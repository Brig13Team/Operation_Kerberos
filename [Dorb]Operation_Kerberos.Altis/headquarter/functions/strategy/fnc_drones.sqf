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
#include "script_component.hpp"

_this params ["_attackLoc"];

private _pos = locationPosition _attackLoc;

private _nearPlayers = allPlayers select { ((_x distance pos)<500) && ((GVARMAIN(side) knowsAbout _x)>1) && (!((vehicle _x) isKindOf "Air")) };

private _weightArray = [];
{
    _weightArray pushBack [([_x] call FUNC(strenghtPlayer)),_x];
} forEach _nearPlayers;

private _target = [_weightArray,0] call EFUNC(common,sel_array_weighted);

HASH_SET(_attackLoc,QGVAR(lastAttackRequest),(-1));

[_target,_attackLoc] call FUNC(drones_requestAirstrike);

_target;
