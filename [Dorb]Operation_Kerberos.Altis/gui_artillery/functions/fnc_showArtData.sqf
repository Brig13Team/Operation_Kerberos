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
#define INCLUDE_GUI
#include "script_component.hpp"

_this params ["_display","_vehicle"];

private _listbox = _display displayCtrl IDC_ARTILLERY_PROPERTIES_ARTILLERY;
private _pitchBank = _vehicle call BIS_fnc_getPitchBank;
private _posASL = getPosASL _vehicle;

{
    _listbox lnbSetText [[_forEachIndex,1],format["%1",_x]];
} forEach [
    _posASL select 0,
    _posASL select 1,
    _posASL select 2,
    _pitchBank select 0,
    _pitchBank select 1,
    (_posASL select 2) call ace_weather_fnc_calculateTemperatureAtHeight,
    (_posASL select 2) call ace_weather_fnc_calculateBarometricPressure,
    ace_weather_currentHumidity
];
