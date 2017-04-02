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

GVAR(radioTypeList) = LHASH_CREATE;

private _allRadios = configProperties [configFile >> "CfgWeapons","(isClass _x)&&{getNumber(_x>>'acre_hasUnique')>0}&&{getNumber(_x>>'acre_isRadio')>0}", true];

{
    private _WeaponName = configName (_x);
    private _displayName = getText (_x >> "displayName");
    private _picture = getText (_x >> "picture");
    private _presetName = [_WeaponName] call acre_api_fnc_getPreset;
    If !(_WeaponName in ["ACRE_BaseRadio","ACRE_PRC77"]) then {
        TRACEV_2(_WeaponName,_presetName);
        private _presetData = [_WeaponName, _presetName] call acre_api_fnc_getPresetData;
        If !(isNil "_presetData") then {
            private _radioHash = LHASH_CREATE;
            HASH_SET(GVAR(radioTypeList),_WeaponName,_radioHash);
            HASH_SET(_radioHash,"displayname",_displayName);
            HASH_SET(_radioHash,"picture",_picture);
            HASH_SET(_radioHash,"presetname",_presetName);
            private _channels = count (HASH_GET_DEF(_presetData,"channels",[])) - 1;
            HASH_SET(_radioHash,"LastChannelIndex",_channels);
        };
    };
} forEach _allRadios;
