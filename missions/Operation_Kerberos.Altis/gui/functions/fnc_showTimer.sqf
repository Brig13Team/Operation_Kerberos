/**
 * Author: Dorbedo
 * shows the timer
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"

If !(hasInterface) exitWith {};

([QGVAR(timer)] call BIS_fnc_rscLayer) cutRsc [QAPP(timer), "PLAIN", 0, true];
if (isNull (uiNamespace getVariable [QGVAR(timer), displayNull])) exitWith {};

GVAR(timerIsShown) = true;

[{
    if (!GVAR(timerIsShown)) exitWith {[_this select 1] call CBA_fnc_removePerFrameEventHandler};
    disableSerialization;
    (_this select 0) params ["_display"];

    private _diff = (GVAR(timer_finish) - CBA_missionTime) max 0;
    private _formatedTime = [_diff,"H:MM:SS"] call CBA_fnc_formatElapsedTime;

    private _ctrl = _display displayCtrl IDC_TIMER_TEXT;
    _ctrl ctrlsetText _formatedTime;
}, 0.2, [uiNamespace getVariable [QGVAR(timer), displayNull]]] call CBA_fnc_addPerFrameHandler;
