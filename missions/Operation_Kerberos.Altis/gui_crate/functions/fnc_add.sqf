/**
 * Author: Dorbedo
 * adds/removes items to/from the list
 *
 * Arguments:
 * 0: <CONTROL> the Listbox
 * 1: <BOOL> add
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
disableSerialization;
params ["_ctrlList","_add"];

private _modifyValue = If (_add) then {GVAR(multiplicator)} else {-1*GVAR(multiplicator)};
// get the updated config
private _curRowIndex = lnbCurSelRow _ctrlList;
private _config = (_ctrlList lnbData [_curRowIndex,0]);

// update the amount
private _curAmount = (([_config] call FUNC(getCurAmount)) + _modifyValue) max 0;
private _isNewItem = !(HASH_HASKEY(GVAR(curInventory),_config));
HASH_SET(GVAR(curInventory),_config,_curAmount);

private _display = ctrlParent _ctrlList;
// update the itemlist
//private _itemlist = GVAR(curItemList) select GVAR(curItemListID);
TRACEV_3((_config in _itemlist),GVAR(curItemList),GVAR(curItemListID));
//If (_config in _itemlist) then {
    _ctrlList = _display displayCtrl IDC_GUI_CRATE_ITEMLIST;
    private _curSelIndex = lnbCurSelRow _ctrlList;
    [_ctrlList,GVAR(curItemList) select GVAR(curItemListID)] call FUNC(showItemList);
    _ctrlList lnbSetCurSelRow _curSelIndex;
//};

// update the inventory

If (_isNewItem) then {
    {
        private _curCfg = _x;
        private _amount = HASH_GET_DEF(GVAR(curInventory),_curCfg,0);
        TRACEV_2(_curCfg,_amount);
        If (_amount <= 0) then {
            HASH_REM(GVAR(curInventory),_curCfg);
        };
    } count HASH_KEYS(GVAR(curInventory));
};

_ctrlList = _display displayCtrl IDC_GUI_CRATE_INVENTORY;
[_ctrlList,HASH_KEYS(GVAR(curInventory))] call FUNC(showItemList);

[_display] call FUNC(updateWeight);
