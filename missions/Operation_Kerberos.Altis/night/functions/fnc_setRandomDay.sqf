/**
 * Author: Dorbedo
 * set a random time
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

If !(isServer) exitWith {};

private _year = 2000 + floor(random 25);
private _date = numberToDate [_year, random 1];

If (GVAR(propabilityDay) > 0.5) then {
    private _time = (random [0, 0.5, 1]) * 24;
    _date set [3, floor _time];
    _date set [4, (_time - (floor _time)) * 60];
};

If (GVAR(propabilityDay) < 0.5) then {
    private _time = (random [0, 0.5, 1]) * 24 + 12;
    if (_time >= 24) then {_time = _time - 24};
    _date set [3, floor _time];
    _date set [4, (_time - (floor _time)) * 60];
};

setDate _date;
