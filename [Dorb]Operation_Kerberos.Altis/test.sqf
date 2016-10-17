#define INCLUDE_GUI
#include "script_component.hpp"

disableSerialization;
createDialog "dtest";

private _ctrl = findDisplay 100000 displayCtrl 100;

private _x = GUI_GRID_CENTER_X;
private _y = GUI_GRID_CENTER_Y;
private _w = GUI_GRID_W * 40;
private _h = GUI_GRID_H * 25;

_ctrl ctrlSetPosition [_x,_y,_w,_h];
//_ctrl ctrlSetBackgroundColor [RAL9011,1];
_ctrl ctrlSetBackgroundColor [RAL9011,1];
_ctrl ctrlSetText "           Settings";
_ctrl ctrlSetFontHeight (GUI_GRID_CENTER_H * 5);
_ctrl ctrlSetTextColor [RAL9002,1];
_ctrl ctrlCommit 0;

private _ctrl = findDisplay 100000 displayCtrl 101;
_ctrl ctrlSetBackgroundColor [RAL6024,1];
_ctrl ctrlSetText "Settings";
_ctrl ctrlSetFontHeight (GUI_GRID_CENTER_H * 2);
_ctrl ctrlSetTextColor [RAL1013,1];
_ctrl ctrlCommit 0;

private _ctrl = findDisplay 100000 displayCtrl 102;
_ctrl ctrlSetBackgroundColor [RAL8019,1];
_ctrl ctrlSetText "Settings";
_ctrl ctrlSetFontHeight (GUI_GRID_CENTER_H * 2);
hint format ["%1",ctrlTextHeight _ctrl];
_ctrl ctrlSetTextColor [RAL1006,1];
_ctrl ctrlCommit 1;
