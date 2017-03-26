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

_this params ["_listbox","_vehicle"];

lnbClear _listbox;

private _pitchBank = _vehicle call BIS_fnc_getPitchBank;
private _posASL = getPosASL _vehicle;
{
    _x params ["_text","_value"];
    if (isLocalized _text) then {_text = localize _text;};
    _listbox lnbaddRow ["_text",format["%1",_value]];
} forEach [
    ["X-Coord",_posASL select 0],
    ["Y-Coord",_posASL select 1],
    ["Height above sea",_posASL select 2],
    ["Pitch",_pitchBank select 0],
    ["Bank",_pitchBank select 1],
    ["Temperature",(_posASL select 2) call ace_weather_fnc_calculateTemperatureAtHeight],
    ["Air-Pressure",(_posASL select 2) call ace_weather_fnc_calculateBarometricPressure],
    ["Humidity",ace_weather_currentHumidity]
];
