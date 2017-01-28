/*
 *  Author: Dorbedo
 *
 *  Description:
 *      unit can copy the loadout
 *
 *  Parameter(s):
 *      0 : OBJECT - target
 *
 *  Returns:
 *      BOOL - player is allowd to copy the loadout
 *
 */
#include "script_component.hpp"

_this params [["_target",objNull,[objNull]]];
If ((isNull _target)||{!isPlayer _target}) exitWith {false};

If !((vehicle player == player)&&(vehicle _target == _target)&&(side player == side _target)) exitWith {false};

private _respawnPos = getMarkerPos (format["respawn_%1",_side]);

((player distance2D _respawnPos) < 20)
