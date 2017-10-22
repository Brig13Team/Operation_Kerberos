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
params ["_dialog"];

{
    private _pic = _dialog displayCtrl (-1*_x);
    TRACEV_1(_pic);
    _pic ctrlSetBackgroundColor [COLOR_BASE_BLUE_SQF];
    _pic ctrlSetTextColor [COLOR_BASE_BLUE_SQF];
    _pic ctrlCommit 0;
} forEach [IDC_ACRE_MENU_BTTN1,IDC_ACRE_MENU_BTTN2,IDC_ACRE_MENU_BTTN3];


private _other_back = _dialog displayCtrl IDC_ACRE_MENU_BACK_REST;
_other_back ctrlsetPosition [
    GUI_DISP_X + GUI_DISP_W*15,
    GUI_DISP_Y + GUI_DISP_H*8,
    GUI_DISP_WAbs - GUI_DISP_W*15,
    GUI_DISP_H*82
];
_other_back ctrlSetBackgroundColor [COLOR_BASE_WHITE_SQF];
_other_back ctrlCommit 0;

private _menu_back = _dialog displayCtrl IDC_ACRE_MENU_BACK_LEFT;
_menu_back ctrlsetPosition [
    GUI_DISP_X,
    GUI_DISP_Y + GUI_DISP_H*8,
    GUI_DISP_W*15,
    GUI_DISP_H*82
];
_menu_back ctrlSetBackgroundColor [COLOR_BASE_GREEN_SQF];
_menu_back ctrlCommit 0;

// tree view
private _picture = ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QUOTE(COMPONENT\data\tree.paa));
private _displayName = localize LSTRING(MENU_TREE);
private _ctrl = _dialog displayCtrl IDC_ACRE_MENU_BTTN1;
_ctrl ctrlAddEventHandler ["ButtonClick",{_this call FUNC(treeShow);true}];
["changepos",[_ctrl,[
    GUI_DISP_X,
    GUI_DISP_Y+GUI_DISP_H*8,
    GUI_DISP_W*15,
    GUI_DISP_H*15
]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (GUI_DISP_H*1.2);
_ctrl ctrlSetTextColor [1,1,1,1];

// group settings
private _picture = ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QUOTE(COMPONENT\data\radio_multi.paa));
private _displayName = localize LSTRING(MENU_GROUP);
private _ctrl = _dialog displayCtrl IDC_ACRE_MENU_BTTN2;
_ctrl ctrlAddEventHandler ["ButtonClick",{[group ace_player] call FUNC(radiosShow);true}];
["changepos",[_ctrl,[
    GUI_DISP_X,
    GUI_DISP_Y+GUI_DISP_H*23,
    GUI_DISP_W*15,
    GUI_DISP_H*15
]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (GUI_DISP_H*1.2);
_ctrl ctrlSetTextColor [1,1,1,1];

// player settings
private _picture = ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QUOTE(COMPONENT\data\radio_single.paa));
private _displayName = localize LSTRING(MENU_SINGLE);
private _ctrl = _dialog displayCtrl IDC_ACRE_MENU_BTTN3;
_ctrl ctrlAddEventHandler ["ButtonClick",{[ace_player] call FUNC(radiosShow);true}];
["changepos",[_ctrl,[
    GUI_DISP_X,
    GUI_DISP_Y+GUI_DISP_H*38,
    GUI_DISP_W*15,
    GUI_DISP_H*15
]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (GUI_DISP_H*1.2);
_ctrl ctrlSetTextColor [1,1,1,1];

private _menu_back_empty = _dialog displayCtrl IDC_ACRE_MENU_BACK_LEFT2;
_menu_back_empty ctrlsetPosition [
    GUI_DISP_X,
    GUI_DISP_Y + GUI_DISP_H*53,
    GUI_DISP_W*15,
    GUI_DISP_H*37
];
_menu_back_empty ctrlSetBackgroundColor [COLOR_BASE_BLUE_SQF];
_menu_back_empty ctrlCommit 0;


// TODO: should be changed after the modern view is created
[] spawn FUNC(treeShow);
