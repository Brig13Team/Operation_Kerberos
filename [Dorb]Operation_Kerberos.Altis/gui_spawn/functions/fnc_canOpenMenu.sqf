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

_this params [["_player",objNull,[objNull]],["_spawntype","",[""]]];

If ((isNull _player)||(!(isPlayer _player))) exitWith {false;};

private _spawnpositions = HASH_GET(GVAR(actionpositions),_spawntype);

If (isNil "_spawnpositions") exitWith {false;};

/// TODO - check sight (lineintersects), add distance, remove actionposition


(({
    ((_player distance _x)<5);
} count _spawnpositions)>0);
