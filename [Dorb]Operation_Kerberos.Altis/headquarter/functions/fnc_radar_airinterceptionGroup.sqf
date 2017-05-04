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
TRACEV_1(_attacktarget);
private _pos = getPos _attacktarget;
private _spawnPos = [_pos,10000,10000,15000] call FUNC(ressources_getsavespawnposair);
_spawnPos set [2,3000];

private _plane = ["plane_ai"] call EFUNC(spawn,getUnit);
private _dir = [_spawnpos, _currentPos] call BIS_fnc_dirTo;
([_spawnpos,GVARMAIN(side),_plane,_dir,true,true,"FLY"] call EFUNC(spawn,vehicle)) params ["_attackGroup","_attackVeh"];
_spawnPos set [2,2000];
([_spawnpos,_attackGroup,_plane,_dir,true,true,"FLY"] call EFUNC(spawn,vehicle)) params ["_attackGroup","_attackVeh2"];

[_attackGroup, _attacktarget, 400, true] call CBA_fnc_taskAttack;

#ifdef DEBUG_MODE_FULL
    [_spawnpos,"SPAWNPOS_AI","ColorRed","o_plane"] call EFUNC(common,debug_marker_create);
#endif

// delay the execution of the ai
GVAR(radar_nextAI) = CBA_missiontime + 60 * (15 + 5 + 5);

[
    {
        // if the planes were defeated don't execute the return
        (({(alive _x)&&{canMove _x}} count [(_this select 0),(_this select 1)])==0)||
        (HASH_GET_DEF(GVAR(radars),"targets",[]) isEqualTo [])
    },
    {
        If (HASH_GET_DEF(GVAR(radars),"targets",[]) isEqualTo []) then {
            _this call FUNC(radar_airInterceptionGroup_return);
        } else {
            [_this select 0, _this select 1,_this select 2] call EFUNC(common,delete);
        };
    },
    [_attackVeh,_attackVeh2,_attackGroup,_spawnPos,_attacktarget],
    (10*60),
    FUNC(radar_airInterceptionGroup_return)
] call CBA_fnc_waitUntilAndExecute;
