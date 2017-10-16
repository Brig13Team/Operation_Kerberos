/**
 * Author: Dorbedo
 * description
 *
 * Arguments:
 * 0: <CONTROL> Button
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

disableSerialization;
params ["_ctrlBttn"];

private _display = ctrlParent _ctrlBttn;

["CrateSpawner",false] call EFUNC(gui_save,OpenMenu);
waitUntil{(!ctrlVisible IDC_SAVE_BTTN1 )};
If ((isNil QEGVAR(gui_save,current))||{EGVAR(gui_save,current) isEqualTo []}) exitWith {};

private _return = EGVAR(gui_save,current);
private _newHash = HASH_DESERIALIZE(_return);



GVAR(curInventory) = _newHash;



private _ctrlList = _display displayCtrl IDC_GUI_CRATE_INVENTORY;
[_ctrlList,HASH_KEYS(GVAR(curInventory))] call FUNC(showItemList);
_ctrlList = _display displayCtrl IDC_GUI_CRATE_ITEMLIST;

_ctrlList = _display displayCtrl IDC_GUI_CRATE_ITEMLIST;
private _curSelIndex = lnbCurSelRow _ctrlList;
[_ctrlList,GVAR(curItemList) select GVAR(curItemListID)] call FUNC(showItemList);
_ctrlList lnbSetCurSelRow _curSelIndex;
