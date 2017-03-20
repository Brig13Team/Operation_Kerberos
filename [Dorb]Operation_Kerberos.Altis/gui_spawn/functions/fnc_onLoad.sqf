/*
 *  Author: Dorbedo
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


disableSerialization;
_this params ["_dialog"];


private _picture = ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QEPAAPATH(acre,tree));
private _displayName = localize LSTRING(MENU_TREE);
private _pos_y = GUI_ECHIDNA_Y + _pos_h*1;
private _ctrl = _dialog displayCtrl IDC_ACRE_MENU_BTTN2;
_ctrl ctrlAddEventHandler ["ButtonClick",{_this call FUNC(treeShow);true}];
["changepos",[_ctrl,[_pos_x, _pos_y, _pos_w, _pos_h]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (GUI_ECHIDNA_METRO_BTTN_H * 0.1);
_ctrl ctrlSetTextColor [1,1,1,1];
