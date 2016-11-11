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
#include "script_component.hpp"
IF (!isMultiplayer) exitWith {true;};
_this params [["_player",objNull,[objNull]],["_spawntype","",[""]]];

If ((isNull _player)||(!(isPlayer _player))) exitWith {
    TRACE("player != player");
    false;
};
If !(vehicle player == player) exitWith {
    TRACE("vehicle player != player");
    false;
};

private _spawnpositions = HASH_GET(GVAR(spawnpositions),_spawntype);

If (isNil "_spawnpositions") exitWith {
    TRACE("spawnposition == nil");
    false;
};


Private _possiblePos = [];
If !(({
    If (((_player distance2D _x)<(5 + CHECK_RADIUS))&&
    ((_player distance2D _x)>CHECK_RADIUS)) then {
        _possiblePos pushBack _x;
        true;
    }else{false;};
} count _spawnpositions)>0) exitWith {
    TRACE("wrong distance");
    false;
};

TRACEV_1(_possiblePos);

(({
    [_x] call FUNC(clearPos);
    private _cur = _x;
    _cur set[2,(_cur select 2)+1];
    private _pPos = getPos player;
    _pPos set[2,(_pPos select 2)+1];
    private _intersects = !( lineIntersects [_cur,_pPos,player]);
    TRACEV_3(_intersects,_cur,_pPos);
    _intersects;
} count _possiblePos)>0);
/// TODO - check sight (lineintersects), add distance, remove actionposition
