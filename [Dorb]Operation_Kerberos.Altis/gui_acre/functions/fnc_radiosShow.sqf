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
// hide all other things
[] call FUNC(hideAll);

// get the tree and the propertiesList
private _display = uiNamespace getVariable QEGVAR(gui_Echidna,dialog);
private _itemlist = _display displayCtrl IDC_ACRE_MENU_ITEMLIST;
private _radiolist = _display displayCtrl IDC_ACRE_MENU_RADIOLIST;
private _properties = _display displayCtrl IDC_ACRE_MENU_PROPERTIES;
