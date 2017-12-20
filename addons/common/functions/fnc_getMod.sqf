/**
 * Author: Dorbedo
 * returns the modname of a config Entry
 *
 * Arguments:
 * 0: <CONFIG> the config to get the Modname
 *
 * Return Value:
 * <STRING> the Name of the Mod
 *
 */

#include "script_component.hpp"

params [["_config",configNull,[configNull]]];

private _mod = "";
private _addOnList = configSourceAddonList _config;
if !(_addOnList isEqualTo []) then {
    private _modList = configSourceModList (configFile >> "CfgPatches" >> (_addOnList select 0));
    if !(_modList isEqualTo []) then {
        _mod = _modList select 0;
    };
};
_mod
