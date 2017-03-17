/*
 *  Author: Dorbedo
 *
 *  Description:
 *      creates the radioList
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

GVAR(radioList) = HASH_CREATE;

private _allRadios = configProperties [configFile >> "CfgWeapons","(isClass _x)&&{(_x>>'acre_hasUnique')>0}&&{(_x>>'acre_isRadio')>0}", true];

{
    private _WeaponName = configName (_x);
    private _displayName = getText (_x >> "displayName");
    private _picture = getText (_x >> "picture");
    private _radioHash = HASH_CREATE;
    HASH_SET(GVAR(radioList),_WeaponName,_radioHash);
    HASH_SET(_radioHash,"displayname",_displayName);
    HASH_SET(_radioHash,"picture",_picture);
    private _presetName = [_WeaponName] call acre_api_fnc_getPreset;
    HASH_SET(_radioHash,"presetname",_presetName);
    private _channels = [];
    {
        _channels set [_forEachIndex,locationNull];
    } forEach (HASH_GET([ARR_2(_WeaponName, _presetName)] call acre_api_fnc_getPresetData,"_channels"));
    private _channel_one = [_WeaponName,1] call FUNC(setFilteredPresetChannel);
    _channels set [0,_channel_one];
    HASH_SET(_radioHash,"channels",_channels);
} forEach _allRadios;
