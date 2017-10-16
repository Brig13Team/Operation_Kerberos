/**
 * Author: Dorbedo
 * description
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _save = HASH_SERIALIZE(GVAR(curinventory));
["CrateSpawner", true, _save] call EFUNC(gui_save,OpenMenu);
