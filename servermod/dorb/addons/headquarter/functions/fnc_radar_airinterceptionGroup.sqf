/*
 *  Author: Dorbedo
 *
 *  Description:
 *      airinterception
 *
 *  Parameter(s):
 *      0 : TARGET - the enemy air-Target
 *
 *  Returns:
 *      ARRAY - parameter for check
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_attacktarget"];

private _pos = getPos _attacktarget;
private _spawnPos = [_pos,10000,10000,15000] call FUNC(ressources_getsavespawnposair);
_spawnPos set [2,3000];

private _plane = ["plane_ai"] call EFUNC(spawn,getUnit);
private _dir = [_spawnpos, _pos] call BIS_fnc_dirTo;
([_spawnpos,GVARMAIN(side),_plane,_dir,true,true,"FLY"] call EFUNC(spawn,vehicle)) params ["_attackGroup","_attackVeh"];


_attackGroup setVariable [QGVAR(target),_attacktarget];
_attackGroup setVariable [QGVAR(timeout),CBA_missiontime + 10*60];
_attackGroup setVariable [QGVAR(spawnpos),_spawnPos];
_attackGroup setVariable [QGVAR(state),"ai_radar"];

#ifdef DEBUG_MODE_FULL
    [_spawnpos,"SPAWNPOS_AI","ColorRed","o_plane"] call EFUNC(common,debug_marker_create);
#endif

private _radaramount = (count HASH_GET_DEF(GVAR(radars),"objects",[])) max 1;
GVAR(radar_nextAI) = CBA_missiontime + 60 * (15 / _radaramount);
