/*
 *  Author: DOrbedo
 *
 *  Description:
 *      starts general display functions
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#define INCLUDE_GUI
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

disableSerialization;
_this params ["_display"];

with uiNamespace do {
    If (isNil QGVAR(currentEchidnaDisplays)) then {
        GVAR(currentEchidnaDisplays) = [];
    };
    GVAR(currentEchidnaDisplays) pushBack _display;
    while {((count GVAR(currentEchidnaDisplays)) > 1)} do {
        private _dispToClose = GVAR(currentEchidnaDisplays) deleteAt 0;
        _dispToClose closeDisplay 1;
    };
};

[_display] call EFUNC(gui_echidna,setBackground);

[_display] call EFUNC(gui_echidna,initHeader);
//[] call FUNC(showMetro);

private _ctrl = _display displayCtrl IDC_ECHIDNA_TASKBAR_MENU_BUTTON;
_ctrl ctrlSetText ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QEPAAPATH(logo,logo_512w));
_ctrl ctrlAddEventHandler ["ButtonClick",FUNC(showMetro)];
