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


// group



// treeview
private _ctrl = _dialog displayCtrl IDC_ACRE_MENU_BTTN3;
_ctrl ctrlSetText "Tree";
_ctrl ctrlAddEventHandler ["ButtonClick",{_this call LINKFUNC(treeShow);true}];
