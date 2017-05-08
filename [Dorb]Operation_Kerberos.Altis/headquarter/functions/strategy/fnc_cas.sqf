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
private _spawnPos = [_pos,5000,5000,10000] call FUNC(ressources_getsavespawnposair);
//TRACEV_2(_pos,_spawnPos);
_spawnPos set [2,500];
_dir = [_spawnpos, _pos] call BIS_fnc_dirTo;
private _attackVehType = ["plane_cas"] call EFUNC(spawn,getUnit);

([_spawnPos,GVARMAIN(side),_attackVehType,_dir,true,true,"FLY"] call EFUNC(spawn,vehicle)) params ["_attackGroup","_attackVeh"];
private _ressourcesHash = HASH_GET_DEF(GVAR(ressources),"cas",locationNull);
HASH_GET_DEF(_ressourcesHash,"units",[]) pushBack _attackVeh;
HASH_SET(_ressourcesHash,"nextexecution",CBA_missiontime + GVAR(ressources_CallInreplenish_CAS));

_group setVariable [QGVAR(target),_attackLoc];
_group setVariable [QGVAR(timeout),CBA_missiontime + 10*60];
_group setVariable [QGVAR(spawnpos),_spawnPos];
_group setVariable [QGVAR(state),"cas_support"];

/*
_attackVeh flyInHeight 500;
private _wp = _attackGroup addWaypoint [_pos, 100];
_wp setWaypointLoiterType "CIRCLE";
_wp setWaypointLoiterRadius 1500;
_wp setWaypointBehaviour "SAD";
_wp setWaypointCombatMode "RED";
_wp setWaypointTimeout [300,400,500];

private _wp = _attackGroup addWaypoint [_spawnPos, 1];
// RTB
[
    {
        (!(alive (_this select 0)))||(isNull (_this select 3))
    },
    {
        _this call FUNC(onFinishAir);
    },
    [_attackVeh,_attackGroup,_spawnpos,_attackLoc],
    (10*60),
    {
        _this call FUNC(onFinishAir);
    }
] call CBA_fnc_waitUntilAndExecute;
//[_attackGroup, _pos, 400] call CBA_fnc_taskAttack;
*/
[_attackVeh,_attackGroup,_spawnpos]
