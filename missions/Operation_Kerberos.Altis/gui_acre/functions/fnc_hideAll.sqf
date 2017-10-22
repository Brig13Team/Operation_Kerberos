/*
 *  Author: Dorbedo
 *
 *  Description:
 *      hides everything
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"
disableSerialization;
private _display = uiNamespace getVariable QEGVAR(gui_main,dialog);
{
    _x params ["_idc",["_handler",[],[[]]]];
    private _ctrl = _display displayCtrl _idc;
    _ctrl ctrlsetPosition [0,0,0,0];
    _ctrl ctrlCommit 0;
    {
        _ctrl ctrlRemoveAllEventHandlers _x;
    }forEach _handler;
} forEach [
    [IDC_ACRE_MENU_ITEMLIST,["LBDrop"]],
    [IDC_ACRE_MENU_RADIOLIST,["LBDrop","LBSelChanged"]],
    [IDC_ACRE_MENU_TREE,["TreeSelChanged"]],
    [IDC_ACRE_MENU_PROPERTIESLIST],
    [IDC_ACRE_MENU_PROPERTIES],
    [IDC_ACRE_MENU_BACK_1],
    [IDC_ACRE_MENU_BACK_2],
    [IDC_ACRE_MENU_BACK_3],
    [IDC_ACRE_MENU_WATERMARK]
];

{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlsetText "";
} forEach [IDC_ACRE_MENU_WATERMARK];

{
    {ctrlDelete _x;} forEach _x;
} forEach GVAR(tempProperties);

{
    private _ctrl = _display displayCtrl _x;
    ["delete",[_ctrl]] call FUNC(AnimBttn);
} forEach [IDC_ACRE_MENU_BTTN6,IDC_ACRE_MENU_BTTN7];
