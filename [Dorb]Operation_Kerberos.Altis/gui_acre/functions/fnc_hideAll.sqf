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
private _display = uiNamespace getVariable QEGVAR(gui_Echidna,dialog);
{
    _x params ["_idc",["_handler",[],[[]]]];
    private _ctrl = _display displayCtrl _idc;
    _ctrl ctrlsetPosition [0,0,0,0];
    _ctrl ctrlCommit 0;
    {
        _ctrl displayRemoveAllEventHandlers _x;
    }forEach _handler;
} forEach [
    [IDC_ACRE_MENU_ITEMLIST],
    [IDC_ACRE_MENU_RADIOLIST],
    [IDC_ACRE_MENU_TREE,[]],
    [IDC_ACRE_MENU_PROPERTIESLIST],
    [IDC_ACRE_MENU_PROPERTIES]
];
