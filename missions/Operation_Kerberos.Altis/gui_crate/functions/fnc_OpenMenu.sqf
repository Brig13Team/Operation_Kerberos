/**
 * Author: Dorbedo
 * opens the spawn menu
 *
 * Arguments:
 * 0: <OBJECT> the target (ACE)
 * 1: <OBJECT> the caller (ACE)
 * 2: <STRING> spawn ID
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

params ["_target","_caller","_spawnID"];

(GVAR(spawns) getVariable _spawnID) params ["_list","_spawnPosition","_spawnDir"];

GVAR(curItemListID) = 0;
GVAR(curItemList) =+ _list;
GVAR(curPos) =+ _spawnPosition;
GVAR(curDir) =+ _spawnDir;

If ((isNil QGVAR(curInventory))||{isNull GVAR(curInventory)}) then {
    GVAR(curInventory) = HASH_CREATE;
} else {
    HASH_DELETE(GVAR(curInventory));
    GVAR(curInventory) = HASH_CREATE;
};

disableSerialization;
createDialog QAPP(dialog);
