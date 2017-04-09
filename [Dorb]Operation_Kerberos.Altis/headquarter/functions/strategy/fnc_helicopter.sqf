/*
 *  Author: Dorbedo
 *
 *  Description:
 *      attacks with a attack helicopter
 *
 *  Parameter(s):
 *      0 : LOCATION - Attacklocation
 *
 *  Returns:
 *      ARRAY - parameter for check
 *
 */
#include "script_component.hpp"

_this params ["_attackLoc"];
//TRACEV_1(_attackLoc);
private _pos = locationPosition _attackLoc;
private _spawnPos = [_pos,4000,4000,10000] call FUNC(ressources_getsavespawnposair);
//TRACEV_2(_pos,_spawnPos);
_spawnPos set [2,500];

private _helicopterType = ["helicopter"] call EFUNC(spawn,getUnit);

([_spawnPos,GVARMAIN(side),_helicopterType] call EFUNC(spawn,vehicle)) params ["_attackGroup","_attackVeh"];
//TRACEV_2(_attackGroup,_attackVeh);

private _costs = [_helicopterType] call FUNC(getCosts);
GVAR(ressources_amount) = GVAR(ressources_amount) - _costs;

_attackVeh flyInHeight 300;
private _wp = _attackGroup addWaypoint [_pos, 0];
_wp setWaypointLoiterType "CIRCLE";
_wp setWaypointLoiterRadius 800;
_wp setWaypointBehaviour "SAD";
_wp setWaypointCombatMode "RED";
_wp setWaypointTimeout [300,400,500];

[_attackGroup, _pos, 400] call CBA_fnc_taskAttack;

[_attackVeh,_attackGroup,_spawnpos]
