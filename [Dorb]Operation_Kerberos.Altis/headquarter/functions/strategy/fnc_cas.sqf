/*
 *  Author: Dorbedo
 *
 *  Description:
 *      attacks with a plane
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
_dir = [_spawnpos, _pos] call BIS_fnc_dirTo;
private _attackVehType = ["plane_cas"] call EFUNC(spawn,getUnit);

([_spawnPos,GVARMAIN(side),_attackVehType,_dir,true,true,"FLY"] call EFUNC(spawn,vehicle)) params ["_attackGroup","_attackVeh"];
private _ressourcesHash = HASH_GET_DEF(GVAR(ressources),"cas",locationNull);
HASH_GET_DEF(_ressourcesHash,"units",[]) pushBack _attackVeh;
HASH_SET(_ressourcesHash,"nextexecution",CBA_missiontime + GVAR(ressources_CallInreplenish_CAS));

_attackVeh flyInHeight 300;
private _wp = _attackGroup addWaypoint [_pos, 0];
_wp setWaypointLoiterType "CIRCLE";
_wp setWaypointLoiterRadius 800;
_wp setWaypointBehaviour "SAD";
_wp setWaypointCombatMode "RED";
_wp setWaypointTimeout [300,400,500];

[_attackGroup, _pos, 400] call CBA_fnc_taskAttack;

[_attackVeh,_attackGroup,_spawnpos]
