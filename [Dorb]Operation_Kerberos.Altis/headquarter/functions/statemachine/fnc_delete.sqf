/*
 *  Author: Dorbedo
 *
 *  Description:
 *      deletes the group, their vehicles and their units
 *
 *  Parameter(s):
 *      0 : GROUP - the group
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_group"];

private _toDelete = [];
{
    _toDelete pushBackUnique _x;
    _toDelete pushBackUnique (vehicle _x);
} forEach (units _group);

_toDelete pushBack _group;
[_toDelete] call EFUNC(common,delete);
