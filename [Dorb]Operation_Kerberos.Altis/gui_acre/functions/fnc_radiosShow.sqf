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
#define INCLUDE_GUI
#include "script_component.hpp"
disableSerialization;

_this params ["_target"];

GVAR(radioSettingsTarget) = _target;

// hide all other things
[] call FUNC(hideAll);

// get the tree and the propertiesList
private _display = uiNamespace getVariable QEGVAR(gui_Echidna,dialog);
private _itemlist = _display displayCtrl IDC_ACRE_MENU_ITEMLIST;
private _radiolist = _display displayCtrl IDC_ACRE_MENU_RADIOLIST;
private _properties = _display displayCtrl IDC_ACRE_MENU_PROPERTIES;

lbClear _itemlist;
lbClear _radiolist;

_itemlist ctrlSetPosition [
    GUI_ECHIDNA_X + 6*GUI_ECHIDNA_W,
    GUI_ECHIDNA_Y + 0.5*GUI_ECHIDNA_H,
    5*GUI_ECHIDNA_W,
    26.5*GUI_ECHIDNA_H
];
_radiolist ctrlSetPosition [
    GUI_ECHIDNA_X + 11.5*GUI_ECHIDNA_W,
    GUI_ECHIDNA_Y + 0.5*GUI_ECHIDNA_H,
    10*GUI_ECHIDNA_W,
    26.5*GUI_ECHIDNA_H
];
_properties ctrlSetPosition [
    GUI_ECHIDNA_X + 22*GUI_ECHIDNA_W,
    GUI_ECHIDNA_Y + 0.5*GUI_ECHIDNA_H,
    17.5*GUI_ECHIDNA_W,
    26.5*GUI_ECHIDNA_H
];

_itemlist ctrlCommit 0;
_radiolist ctrlCommit 0;
_properties ctrlCommit 0;
