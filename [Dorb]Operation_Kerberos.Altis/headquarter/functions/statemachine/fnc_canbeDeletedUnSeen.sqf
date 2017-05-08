/*
 *  Author: Dorbedo
 *
 *  Description:s
 *      returns if the group is unseen by players (distance to high)
 *
 *  Parameter(s):
 *      0 : GROUP - the group
 *
 *  Returns:
 *      BOOL - is unseen
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_group"];

private _leader = (leader _group);
{
    If ((_leader distance2d _x) > 5000) exitWith {true};
    false;
} forEach (([] call CBA_fnc_players) + (allUnitsUAV select {side _x == GVARMAIN(side)}));
