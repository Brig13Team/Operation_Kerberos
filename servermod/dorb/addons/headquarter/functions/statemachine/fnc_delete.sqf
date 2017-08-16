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

private _vehicles = [];
{
    _toDelete pushBackUnique _x;
    If (vehicle _x != _x) then {
        _vehicles pushBackUnique (vehicle _x);
        _toDelete pushBackUnique (vehicle _x);
    };
} forEach (units _group);

{
    private _curVeh = _x;
    {
        if ((group _x)!=_group) then {
            _toDelete pushBackUnique (group _x);
            _toDelete pushBackUnique _x;
        };
    } forEach (crew _curVeh);
} forEach _vehicles;

_toDelete pushBack _group;
[_toDelete] call EFUNC(common,delete);
