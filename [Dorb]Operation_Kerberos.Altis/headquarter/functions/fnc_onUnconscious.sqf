/*
 *  Author: Dorbedo
 *
 *  Description:
 *      ACE - unconcoius Event
 *
 *  Parameter(s):
 *      0 : OBJECT - Player who got unconcious
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params ["_player"];

private _key = (getPos _player) call FUNC(dz_convert);
CHECK(_key isEqualTo "") // not in the area

private _zoneHash = HASH_GET(GVAR(dangerzones),_key);
private _unconciousArray = HASH_GET(_zoneHash,"unconcious");
If (isNil "_unconciousArray") then {
    HASH_SET(_zoneHash,"unconcious",[]);
    HASH_SET(_zoneHash,"unconciousPlayers",[]);
};

private _unconciousHash = HASH_CREATE;
private _strenghtArray = _player call FUNC(strengthPlayer);
/// create a hash for monitoring th revive
HASH_SET(_unconciousHash,"player",_player);
HASH_GET(_zoneHash,"unconciousPlayers") pushBackUnique _player;
HASH_SET(_unconciousHash,"type",_strenghtArray select 0);
HASH_SET(_unconciousHash,"value",_strenghtArray select 1);
HASH_SET(_unconciousHash,"threa",_strenghtArray select 2);
HASH_GET(_zoneHash,"unconcious") pushBack _unconciousHash;
/// modify the enemy Strenght
private _strenghtEnemy = HASH_GET(_zoneHash,"enemystrenght");
If (isNil "_strenghtEnemy") then {_strenghtEnemy = 0;};
_strenghtEnemy = (_strenghtEnemy - (_strenghtArray select 1)) max 0;
HASH_SET(_zoneHash,"enemystrenght",_strenghtEnemy);
