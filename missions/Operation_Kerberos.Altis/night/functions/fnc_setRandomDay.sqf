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

TRACE_1(_date);
setDate _date;
