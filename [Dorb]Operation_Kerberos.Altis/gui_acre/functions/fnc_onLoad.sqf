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


private _pos_x = GUI_ECHIDNA_X;
private _pos_y = GUI_ECHIDNA_Y;
private _pos_w = GUI_ECHIDNA_W*5;
private _pos_h = GUI_ECHIDNA_H*5.5;

private _picture = "\a3\ui_f\data\gui\rsc\rscdisplaymain\menu_multiplayer_ca.paa";
private _displayName = "Blubb";


// player
private _ctrl = _dialog displayCtrl IDC_ACRE_MENU_BTTN1;
_ctrl ctrlAddEventHandler ["ButtonClick",{[player] call FUNC(radiosShow);true}];
["changepos",[_ctrl,[_pos_x, _pos_y, _pos_w, _pos_h]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (_pos_h * 0.1);
_ctrl ctrlSetTextColor [1,1,1,1];


// group
private _pos_y = GUI_ECHIDNA_Y + _pos_h*1;
private _ctrl = _dialog displayCtrl IDC_ACRE_MENU_BTTN2;
_ctrl ctrlAddEventHandler ["ButtonClick",{[group player] call FUNC(radiosShow);true}];
["changepos",[_ctrl,[_pos_x, _pos_y, _pos_w, _pos_h]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (GUI_ECHIDNA_METRO_BTTN_H * 0.1);
_ctrl ctrlSetTextColor [1,1,1,1];

// treeview
private _pos_y = GUI_ECHIDNA_Y + _pos_h*2;
private _ctrl = _dialog displayCtrl IDC_ACRE_MENU_BTTN3;
_ctrl ctrlAddEventHandler ["ButtonClick",{_this call FUNC(treeShow);true}];
["changepos",[_ctrl,[_pos_x, _pos_y, _pos_w, _pos_h]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (GUI_ECHIDNA_METRO_BTTN_H * 0.1);
_ctrl ctrlSetTextColor [1,1,1,1];

private _pos_y = GUI_ECHIDNA_Y + _pos_h*3;
private _ctrl = _dialog displayCtrl IDC_ACRE_MENU_BTTN4;
//_ctrl ctrlAddEventHandler ["ButtonClick",{_this call FUNC(treeShow);true}];
["changepos",[_ctrl,[_pos_x, _pos_y, _pos_w, _pos_h]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (GUI_ECHIDNA_METRO_BTTN_H * 0.1);
_ctrl ctrlSetTextColor [1,1,1,1];

private _pos_y = GUI_ECHIDNA_Y + _pos_h*4;
private _ctrl = _dialog displayCtrl IDC_ACRE_MENU_BTTN5;
//_ctrl ctrlAddEventHandler ["ButtonClick",{_this call FUNC(treeShow);true}];
["changepos",[_ctrl,[_pos_x, _pos_y, _pos_w, _pos_h]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (GUI_ECHIDNA_METRO_BTTN_H * 0.1);
_ctrl ctrlSetTextColor [1,1,1,1];
