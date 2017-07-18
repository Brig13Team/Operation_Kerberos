/*
 *  Author: Dorbedo
 *
 *  Description:
 *      airinterception
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

private _spawnPos = [_pos,10000,10000,15000] call FUNC(ressources_getsavespawnposair);

_spawnPos set [2,3000];

private _plane = ["plane_ai"] call EFUNC(spawn,getUnit);
private _dir = [_spawnpos, _pos] call BIS_fnc_dirTo;
([_spawnpos,GVARMAIN(side),_plane,_dir,true,true,"FLY"] call EFUNC(spawn,vehicle)) params ["_attackGroup","_attackVeh"];
private _ressourcesHash = HASH_GET_DEF(GVAR(ressources),"airinterception",locationNull);

_attackGroup setVariable [QGVAR(target),_attackLoc];
_attackGroup setVariable [QGVAR(timeout),CBA_missiontime + 10*60];
_attackGroup setVariable [QGVAR(spawnpos),_spawnPos];
_attackGroup setVariable [QGVAR(state),"ai_support"];

HASH_GET_DEF(_ressourcesHash,"units",[]) pushBack _attackVeh;
HASH_SET(_ressourcesHash,"nextexecution",CBA_missiontime + GVAR(ressources_CallInreplenish_airinterception));

/*
_attackVeh flyInHeight 800;
private _wp = _attackGroup addWaypoint [_pos, 0];
_wp setWaypointLoiterType "CIRCLE";
_wp setWaypointLoiterRadius 1500;
_wp setWaypointBehaviour "SAD";
_wp setWaypointCombatMode "RED";

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
