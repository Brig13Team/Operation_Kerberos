/*
 * Author: Dorbedo
 * Checks if the radio is initialized correct and reinitializes
 *
 * Arguments:
 * 0: player to check
 *
 * Return Value:
 * none
 *
 *
 * Public: Yes
 */
 #include "script_component.hpp"

_this params ["_player"];

private _allItems = (uniformItems _player) + (vestItems _player) + (backpackItems _player);

private _allItemsToCheck = _allItems select {!(getText(configfile >> "CfgWeapons" >> _x >> "acre_baseClass") isEqualTo "")};


{
    private _radioExists = [_radioId] call acre_sys_radio_fnc_radioExists;
    if (_radioExists) then {
        private _baseName = (configName (inheritsFrom (configFile >> "CfgWeapons" >> _radioId)));
        [acre_player, _radioID, _baseName] call acre_lib_fnc_replaceGear;
    };
} forEach _allItemsToCheck;
