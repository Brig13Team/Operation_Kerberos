/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


_this params [["_vehicle",objNull,[objNull]]];

If (isNull _vehicle) exitWith {[]};


private _magazines = [];
{
    private _turretPath = _x;
    private _cur = [_vehicle, _turretPath] call ace_rearm_fnc_getConfigMagazines;
    _cur = _cur arrayIntersect _cur; // we only want unique elements
    _magazines append _cur;
} forEach [[0]];

_magazines;
