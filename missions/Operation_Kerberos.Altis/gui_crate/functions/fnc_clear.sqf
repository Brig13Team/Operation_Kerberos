/**
 * Author: Dorbedo
 * clear the inventory-list
 *
 * Arguments:
 * 0: <CONTROL> the button
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_button"];

private _display = ctrlParent _button;

HASH_DELETE(GVAR(curInventory));
GVAR(curInventory) = HASH_CREATE;

[_display displayCtrl IDC_GUI_CRATE_INVENTORY,[]] call FUNC(showItemList);
[_display displayCtrl IDC_GUI_CRATE_ITEMLIST,GVAR(curItemList) select GVAR(curItemListID)] call FUNC(showItemList);
[_display] call FUNC(updateWeight);
