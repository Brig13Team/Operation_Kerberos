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
If ((isNull _target)/*||{!isPlayer _target}*/) exitWith {false};

If !((vehicle ace_player == ace_player)&&(vehicle _target == _target)&&(side ace_player == side _target)) exitWith {false};

private _respawnPos = getMarkerPos GVARMAIN(respawnMarker);

((ace_player distance2D _respawnPos) < 20)
