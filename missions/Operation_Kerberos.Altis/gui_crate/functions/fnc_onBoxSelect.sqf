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

HASH_DELETE(GVAR(curInventory));

private _value = _control lbValue _index;
If (_value isEqualTo 0) then {
    GVAR(curInventory) = [];
} else {
    GVAR(curInventory) = [];
    private _object = [_control lbData _index] call BIS_fnc_objectFromNetId;
    {
        private _curCfg = [_x] call CBA_fnc_getItemConfig;
        GVAR(curInventory) pushBack ([_curCfg,""] call BIS_fnc_configPath);
    } forEach ((weaponCargo _object) + (itemCargo _object) + (magazineCargo _object));
};

private _ctrlList = (ctrlParent _control) displayCtrl IDC_GUI_CRATE_INVENTORY;
[_ctrlList,HASH_KEYS(GVAR(curInventory))] call FUNC(showItemList);
