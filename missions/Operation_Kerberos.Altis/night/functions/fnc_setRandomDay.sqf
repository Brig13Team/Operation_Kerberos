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

private _year = 2026;
private _month = 2;
private _day = 1 + random [0, 17, 31];
private _hour = random 24;
private _minute = random 60;

TRACE_5(_year,_month,_day,_hour,_minute);
setDate [_year, _month, _day, _hour, _minute];
