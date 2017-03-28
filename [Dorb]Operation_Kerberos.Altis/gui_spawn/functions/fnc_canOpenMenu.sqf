/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns if the player can open the vehiclespawn menu
 *
 *  Parameter(s):
 *      0 : OBJECT - player
 *
 *  Returns:
 *      BOOL - is allowed to open the list
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_player",objNull,[objNull]],["_spawnID","",[""]]];

If ((isNull _player)||(!(isPlayer _player))||(!(vehicle player == player))) exitWith {false;};

private _spawnArray = HASH_GET_DEF(GVAR(spawns),_spawnID,[]);

If (_spawnArray isEqualTo []) exitWith {false;};

If ((_player distance2D (_spawnArray select 1)) > (5 + CHECK_RADIUS)) exitWith {false};

/*
private _cur =+ (_spawnArray select 1):
_cur set[2,(_cur select 2)+1];
private _pPos = getPos _player;
_pPos set[2,(_pPos select 2)+1];

!(terrainIntersect [_cur,_pPos]);
*/
true
