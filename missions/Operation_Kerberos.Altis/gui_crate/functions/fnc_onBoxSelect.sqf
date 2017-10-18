/**
 * Author: Dorbedo
 * combo box selection changed
 *
 * Arguments:
 * 0: <CONTROL> the combobox
 * 1: <SCALAR> the selected index
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_control","_index"];

private _value = _control lbValue _index;
TRACEV_3(_control,_index,_value);
If (_value isEqualTo 0) then {
    /*HASH_DELETE(GVAR(curInventory));
    GVAR(curInventory) = HASH_CREATE;*/
} else {
    HASH_DELETE(GVAR(curInventory));
    GVAR(curInventory) = HASH_CREATE;
    private _object = (_control lbData _index) call BIS_fnc_objectFromNetId;
    TRACEV_2(_object,((weaponCargo _object) + (itemCargo _object) + (magazineCargo _object)));
    {
        private _curCfg = [_x] call CBA_fnc_getItemConfig;
        private _key = [_curCfg,""] call BIS_fnc_configPath;
        private _value = HASH_GET_DEF(GVAR(curInventory),_key,0) + 1;
        HASH_SET(GVAR(curInventory),_key,_value);
    } forEach ((weaponCargo _object) + (itemCargo _object) + (magazineCargo _object));
};

private _ctrlList = (ctrlParent _control) displayCtrl IDC_GUI_CRATE_INVENTORY;
[_ctrlList,HASH_KEYS(GVAR(curInventory))] call FUNC(showItemList);
[ctrlParent _control] call FUNC(updateWeight);

_ctrlList = (ctrlParent _control) displayCtrl IDC_GUI_CRATE_ITEMLIST;
[_ctrlList,GVAR(curItemList) select GVAR(curItemListID)] call FUNC(showItemList);
