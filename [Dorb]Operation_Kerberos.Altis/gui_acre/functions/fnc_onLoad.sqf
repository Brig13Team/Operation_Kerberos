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

// player
private _ctrl = _dialog displayCtrl IDC_ACRE_MENU_BTTN1;
//_ctrl ctrlSetText "Tree";
_ctrl ctrlAddEventHandler ["ButtonClick",{[player] call FUNC(radiosShow);true}];


// group
private _ctrl = _dialog displayCtrl IDC_ACRE_MENU_BTTN2;
//_ctrl ctrlSetText "Tree";
_ctrl ctrlAddEventHandler ["ButtonClick",{[group player] call FUNC(radiosShow);true}];


// treeview
private _ctrl = _dialog displayCtrl IDC_ACRE_MENU_BTTN3;
//_ctrl ctrlSetText "Tree";
_ctrl ctrlAddEventHandler ["ButtonClick",{_this call FUNC(treeShow);true}];
