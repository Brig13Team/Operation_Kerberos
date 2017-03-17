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

private _key = (getPos _player) call FUNC(dzconvert);
CHECK(_key isEqualTo "") // not in the area

private _zoneHash = HASH_GET(GVAR(dangerzones),_key);
if (isNil "_zoneHash") then {
    _zoneHash = HASH_CREATE;
    HASH_SET(GVAR(dangerzones),_key,_zoneHash);
};
private _unconciousArray = HASH_GET(_zoneHash,"unconcious");
If (isNil "_unconciousArray") then {
    HASH_SET(_zoneHash,"unconcious",[]);
    HASH_SET(_zoneHash,"unconciousPlayers",[]);
};

private _unconciousHash = HASH_CREATE;
private _strengthArray = _player call FUNC(strengthPlayer);
/// create a hash for monitoring th revive
HASH_SET(_unconciousHash,"player",_player);
HASH_GET(_zoneHash,"unconciousPlayers") pushBackUnique _player;
HASH_SET(_unconciousHash,"type",_strengthArray select 0);
HASH_SET(_unconciousHash,"value",_strengthArray select 1);
HASH_SET(_unconciousHash,"threa",_strengthArray select 2);
HASH_GET(_zoneHash,"unconcious") pushBack _unconciousHash;
/// modify the enemy strength
private _strengthEnemy = HASH_GET(_zoneHash,"enemystrength");
If (isNil "_strengthEnemy") then {_strengthEnemy = 0;};
_strengthEnemy = (_strengthEnemy - (_strengthArray select 1)) max 0;
HASH_SET(_zoneHash,"enemystrength",_strengthEnemy);
