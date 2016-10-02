/*
    Author: Dorbedo
    v1.0

    Description:
        ads a vakue to the Dangeraray when a unit(ai) git killed

    Parameter(s):
        none

    Returns:
        none

*/
#include "script_component.hpp"
_this params ["_killedUnit","_killer","_instigator"];


private _key = (getPos _player) call FUNC(dz_convert);
CHECK(_key isEqualTo "") // not in the area


/// register the enemy
private _strengthArray = [_killer] call FUNC(strengthPlayer);
private _keyX = parsenumber ((_key splitString "_") select 0);
private _keyY = parsenumber ((_key splitString "_") select 1);
private _maxKey = (HASH_GET(GVAR(dangerzones),"distance") * 2)/HASH_GET(GVAR(dangerzones),"gridsize");

{
    _x params ["_tempkeyX","_tempkeyY","_value"];
    If ((_tempkeyX>=0)&&(_tempkeyX<_maxKey)&&(_tempkeyY>=0)&&(_tempkeyY<_maxKey)) then {
        private _tempkey = format ["%1_%2",_tempkeyX,_tempkeyY];
        private _zoneHash = HASH_GET(GVAR(dangerzones),_tempkey);
        private _strenghtEnemy = HASH_GET(_zoneHash,"enemystrenght");
        If (isNil "_strenghtEnemy") then {_strenghtEnemy = 0;};
        _strenghtEnemy = (_strenghtEnemy + _value);
        HASH_SET(_zoneHash,"enemystrenght",_strenghtEnemy);
    };
} forEach [
    [_key,_strengthArray select 1],
    [_keyX-1,_keyY-1,(_strengthArray select 1)*HQ_DANGERMOD],
    [_keyX-1,_keyY+1,(_strengthArray select 1)*HQ_DANGERMOD],
    [_keyX+1,_keyY+1,(_strengthArray select 1)*HQ_DANGERMOD],
    [_keyX+1,_keyY+1,(_strengthArray select 1)*HQ_DANGERMOD]
];
