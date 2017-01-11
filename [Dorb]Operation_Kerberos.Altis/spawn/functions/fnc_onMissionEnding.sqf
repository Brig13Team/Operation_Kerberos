/*
 *  Author: Dorbedo
 *
 *  Description:
 *      called after a main mission has ended
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params [["_centerpos",EGVAR(mission,centerPos),[[]]]];

GVAR(targetHouses) = [];

[_centerpos,2200] call FUNC(cleanup_full);
