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
private _spawnPos = [_pos,5000,5000,10000] call FUNC(ressources_getsavespawnposair);
//TRACEV_2(_pos,_spawnPos);
_spawnPos set [2,500];

private _helicopterType = ["helicopter"] call EFUNC(spawn,getUnit);

([_spawnPos,GVARMAIN(side),_helicopterType] call EFUNC(spawn,vehicle)) params ["_attackGroup","_attackVeh"];
_attackVeh flyInHeight 500;
private _ressourcesHash = HASH_GET_DEF(GVAR(ressources),"helicopter",locationNull);

_attackGroup setVariable [QGVAR(target),_attackLoc];
_attackGroup setVariable [QGVAR(timeout),CBA_missiontime + 10*60];
_attackGroup setVariable [QGVAR(spawnpos),_spawnPos];
_attackGroup setVariable [QGVAR(state),"cas_support"];

HASH_GET_DEF(_ressourcesHash,"units",[]) pushBack _attackVeh;
HASH_SET(_ressourcesHash,"nextexecution",CBA_missiontime + GVAR(ressources_CallInreplenish_helicopter));
//TRACEV_2(_attackGroup,_attackVeh);




/*
_attackVeh flyInHeight 150;
_pos set [2,150];
private _wp = _attackGroup addWaypoint [_pos, 0];
_wp setWaypointLoiterType "CIRCLE";
_wp setWaypointLoiterRadius 800;
_wp setWaypointBehaviour "COMBAT";
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
