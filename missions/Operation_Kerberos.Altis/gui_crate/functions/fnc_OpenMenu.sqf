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
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_target","_caller","_spawnID"];

If ((!isNil QEFUNC(gui_arsenal,preload))&&{!(missionNamespace getVariable [QEGVAR(gui_arsenal,isPreloaded),true])}) exitWith {
    [] spawn EFUNC(gui_arsenal,preload);
    [
        {missionNamespace getVariable [QEGVAR(gui_arsenal,isPreloaded),false]},
        {_this spawn FUNC(OpenMenu)},
        _this,
        5
    ] call CBA_fnc_waitUntilAndExecute;
};

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
