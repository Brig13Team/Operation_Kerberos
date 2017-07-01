/*
 *  Author: iJesuz
 *
 *  Description:
 *      condition for "Return to Base"
 *
 *  Parameter(s):
 *      0 : HASH    - mission
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission"];

private _position = HASH_GET(_mission, "location") select 1;
private _radius   = HASH_GET(_mission, "radius");

if ((count allPlayers) == ({ (_x distance2D _position) < _radius } count allPlayers)) exitWith { "Succeeded" };

""
