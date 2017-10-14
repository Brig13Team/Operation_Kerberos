/**
 * Author: Dorbedo
 * filters the left list by category
 *
 * Arguments:
 * 0: <CONTROL> the button
 * 1: <SCALAR> the category
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_buttonsCtrl","_id"];

GVAR(curItemListID) = _id;
private _curList = GVAR(curItemList) select _id;

private _ctrl = (ctrlParent _buttonsCtrl) displayCtrl IDC_GUI_CRATE_ITEMLIST;

[_ctrl,_curList] call FUNC(showItemList);
