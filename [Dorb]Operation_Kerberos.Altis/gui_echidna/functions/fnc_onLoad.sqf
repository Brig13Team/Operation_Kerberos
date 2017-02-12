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
_this params ["_dialog"];
TRACEV_1(_this);

[_dialog] call EFUNC(gui_echidna,setBackground);

[_dialog] call EFUNC(gui_echidna,initHeader);
//[] call FUNC(showMetro);

private _ctrl = _dialog displayCtrl IDC_ECHNIDA_TASKBAR_MENU_BUTTON;
_ctrl ctrlSetText ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QEPAAPATH(logo,logo_512w));
_ctrl ctrlAddEventHandler ["ButtonClick",FUNC(showMetro)];
