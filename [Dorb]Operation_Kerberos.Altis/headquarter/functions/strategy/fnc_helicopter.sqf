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

private _pos = locationPosition _attackLoc;
private _spawnPos = [_pos,4000,4000,10000] call FUNC(ressources_getsavespawnposair);

_spawnPos set [2,500];

private _helicopterType = ["helicopter"] call EFUNC(spawn,getUnit);

([_spawnPos,GVARMAIN(side),_helicopterType] call EFUNC(spawn,vehicle)) params ["_attackGroup","_attackVeh"];

[_attackGroup, _pos, 400] call CBA_fnc_taskAttack;

[_attackVeh,_attackGroup,_spawnpos]
