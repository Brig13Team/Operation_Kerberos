/*
 *  Author: Dorbedo
 *
 *  Description:
 *      handles the timer
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"
disableSerialization;
private _difference = GVAR(timer_finish) - CBA_missiontime;

If (_difference <= 0) exitWith {
    IDD_TIMER cutText ["","PLAIN"];
    uiNamespace setvariable [QGVAR(timer),nil];
    [this select 1] call CBA_fnc_removePerFrameHandler;
    GVAR(timer_handle) = nil;
    GVAR(timer_parameter) call GVAR(timer_code);
};

QAPP(timer) cutRsc [QAPP(timer),"PLAIN"];
disableSerialization;
private _display = uiNamespace getvariable QGVAR(timer);
/// set current time
If (_difference > 10) then {
    _difference = format["%1",(floor(_difference/60))];
}else{
    _difference = format["0%1",(floor(_difference/60))];
};

if (!isNull _display) then {
    private _headerCtrl = _display displayCtrl IDC_TIMER_TEXT;
    _headerCtrl ctrlSetText _difference;
};
