/*
 *  Author: Dorbedo
 *
 *  Description:
 *      displays the timer
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#define INCLUDE_GUI
#include "script_component.hpp"

CHECK(!hasInterface)
CHECK(isNil QEGVAR(mission,endzeit))

private _endtime = EGVAR(mission,endzeit);
private _currenttime = if (ismultiplayer) then {servertime} else {time};
private _difference = _endtime - _currenttime;
If (_difference <= 0) exitWith {
    //// disable timer
    IDD_TIMER cutText ["","PLAIN"];
    uiNamespace setvariable [QGVAR(timer),nil];
};

//// show timer
IDD_TIMER cutRsc [QAPP(timer),"PLAIN"];
disableSerialization;
private _display = uiNamespace getvariable QGVAR(timer);
/// set current time
if (!isNull _display) then {
    private _headerCtrl = _display displayCtrl IDC_TIMER_TEXT;
    _headerCtrl ctrlSetText format["%1",(floor(_difference/60))];
};
/// call timer again
uisleep 60;
[] call FUNC(timer);
