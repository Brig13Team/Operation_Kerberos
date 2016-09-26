/*
 * Author: Dorbedo
 * Sets the gear after respawn
 *
 * Arguments:
 * 0: player <OBJECT>
 * 1: gear <ARRAY>
 * 2: [weapon,muzzle] <ARRAY>
 *
 * Return Value:
 * none
 *
 * Public: Yes
 */
#include "script_component.hpp"
_this params [["_player",objNull,[objNull]],["_loadout",[],[[]]],["_weapons",["",""],[[]],[2]]];
If !((isNull _player)||{isPlayer _player}) exitWith {};

if (!(_loadout isEqualTo [])) then {
    _player setUnitLoadout _loadout;
};

[player,_weapons select 0,_weapons select 1] call CBA_fnc_selectWeapon;
