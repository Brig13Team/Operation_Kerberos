/*
 *  Author: DOrbedo
 *
 *  Description:
 *      starts general display functions
 *
 *  Parameter(s):
 *      0: DIALOG - the radio-dialog
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

private _menu_back = _dialog displayCtrl IDC_ACRE_MENU_BACK_LEFT;
private _other_back = _dialog displayCtrl IDC_ACRE_MENU_BACK_REST;
private _header = _dialog displayCtrl IDC_ACRE_MENU_HEADER;
private _header_text = _dialog displayCtrl IDC_ACRE_MENU_HEADER_TEXT;
private _header_pic = _dialog displayCtrl IDC_ACRE_MENU_HEADER_PIC;


_menu_back ctrlsetPosition [
    _pos_x,
    _pos_y,
    _pos_w,
    GUI_ECHIDNA_H * 27.5
];
_menu_back ctrlSetBackgroundColor [RAL6018,1];
_menu_back ctrlCommit 0;
{
    private _pic = _dialog displayCtrl (-1*_x);
    TRACEV_1(_pic);
    _pic ctrlSetBackgroundColor [RAL5015,1];
    _pic ctrlSetTextColor [RAL5015,1];
    _pic ctrlCommit 0;
} forEach [IDC_ACRE_MENU_BTTN1,IDC_ACRE_MENU_BTTN2,IDC_ACRE_MENU_BTTN3,IDC_ACRE_MENU_BTTN4,IDC_ACRE_MENU_BTTN5];

_other_back ctrlsetPosition [
    _pos_x + _pos_w,
    _pos_y + GUI_ECHIDNA_H * 2,
    GUI_ECHIDNA_WAbs - _pos_w,
    GUI_ECHIDNA_H * 27.5 - GUI_ECHIDNA_H * 2
];
_other_back ctrlSetBackgroundColor [RAL9010,1];
_other_back ctrlCommit 0;

_header ctrlsetPosition [
    _pos_x + _pos_w,
    _pos_y,
    GUI_ECHIDNA_WAbs - _pos_w,
    GUI_ECHIDNA_H * 2
];
_header ctrlSetBackgroundColor [RAL7004,1];
_header ctrlCommit 0;

_header_pic ctrlsetPosition [
    _pos_x + (GUI_ECHIDNA_WAbs - _pos_w)/2 - GUI_ECHIDNA_H * 2,
    _pos_y + GUI_ECHIDNA_H * 0.1,
    GUI_ECHIDNA_H * 1.8,
    GUI_ECHIDNA_H * 1.8
];
_header_pic ctrlSetBackgroundColor [RAL7004,1];
_header_pic ctrlSetText (getText(configfile >> "CfgMods" >> "ACRE2" >> "picture"));
_header_pic ctrlSetTextColor [1,1,1,1];
_header_pic ctrlCommit 0;

_header_text ctrlsetPosition [
    _pos_x + (GUI_ECHIDNA_WAbs - _pos_w)/2,
    _pos_y,
    (GUI_ECHIDNA_WAbs - _pos_w)/2,
    GUI_ECHIDNA_H * 2
];
_header_text ctrlSetBackgroundColor [RAL7004,1];
_header_text ctrlsetText localize LSTRING(HEADER);
_header_text ctrlSetTextColor [RAL9005,1];
_header_text ctrlCommit 0;






// modern view
private _picture = "a3\ui_f\data\igui\cfg\targeting\empty_ca.paa";
private _displayName = localize LSTRING(MENU_MODERN);
private _ctrl = _dialog displayCtrl IDC_ACRE_MENU_BTTN1;
_ctrl ctrlAddEventHandler ["ButtonClick",{true}];
["changepos",[_ctrl,[_pos_x, _pos_y, _pos_w, _pos_h]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (_pos_h * 0.1);
_ctrl ctrlSetTextColor [1,1,1,1];


// tree view
private _picture = ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QUOTE(COMPONENT\data\tree.paa));
private _displayName = localize LSTRING(MENU_TREE);
private _pos_y = GUI_ECHIDNA_Y + _pos_h*1;
private _ctrl = _dialog displayCtrl IDC_ACRE_MENU_BTTN2;
_ctrl ctrlAddEventHandler ["ButtonClick",{_this call FUNC(treeShow);true}];
["changepos",[_ctrl,[_pos_x, _pos_y, _pos_w, _pos_h]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (GUI_ECHIDNA_METRO_BTTN_H * 0.1);
_ctrl ctrlSetTextColor [1,1,1,1];

// group settings
private _picture = ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QUOTE(COMPONENT\data\radio_multi.paa));
private _displayName = localize LSTRING(MENU_GROUP);
private _pos_y = GUI_ECHIDNA_Y + _pos_h*2;
private _ctrl = _dialog displayCtrl IDC_ACRE_MENU_BTTN3;
_ctrl ctrlAddEventHandler ["ButtonClick",{[group player] call FUNC(radiosShow);true}];
["changepos",[_ctrl,[_pos_x, _pos_y, _pos_w, _pos_h]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (GUI_ECHIDNA_METRO_BTTN_H * 0.1);
_ctrl ctrlSetTextColor [1,1,1,1];

// player settings
private _picture = ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QUOTE(COMPONENT\data\radio_single.paa));
private _displayName = localize LSTRING(MENU_SINGLE);
private _pos_y = GUI_ECHIDNA_Y + _pos_h*3;
private _ctrl = _dialog displayCtrl IDC_ACRE_MENU_BTTN4;
_ctrl ctrlAddEventHandler ["ButtonClick",{[player] call FUNC(radiosShow);true}];
["changepos",[_ctrl,[_pos_x, _pos_y, _pos_w, _pos_h]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (GUI_ECHIDNA_METRO_BTTN_H * 0.1);
_ctrl ctrlSetTextColor [1,1,1,1];

// not used
private _picture = "a3\ui_f\data\igui\cfg\targeting\empty_ca.paa";
private _displayName = "";
private _pos_y = GUI_ECHIDNA_Y + _pos_h*4;
private _ctrl = _dialog displayCtrl IDC_ACRE_MENU_BTTN5;
//_ctrl ctrlAddEventHandler ["ButtonClick",{true}];
["changepos",[_ctrl,[_pos_x, _pos_y, _pos_w, _pos_h]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (GUI_ECHIDNA_METRO_BTTN_H * 0.1);
_ctrl ctrlSetTextColor [1,1,1,1];





// TODO: should be changed after the modern view is created
[] spawn FUNC(treeShow);
