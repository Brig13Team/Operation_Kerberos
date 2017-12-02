/**
 * Author: Dorbedo
 * filters the itemlist
 *
 * Arguments:
 * 0: <ARRAY> the itemlist
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_itemlist",[],[[]]]];

{
    _x params [["_itemCfg","",[""]]];
    If ((!(HASH_HASKEY(GVAR(libary),_itemCfg)))&&{!(_itemCfg isEqualTo "")}) then {
        private _cfg = [_itemCfg,configFile] call BIS_fnc_configPath;
        private _modName = [_cfg] call EFUNC(common,getModName);
        private _mags = getArray(_cfg >> "magazines");
        {
            If (isClass (_cfg >> _x)) then {
                _mags = _mags + getarray(_cfg >> _x >> "magazines");
            };
        } foreach getarray(_cfg >> "muzzles");

        _mags = _mags apply {[configFile >> "CfgMagazines" >> _x,""] call BIS_fnc_configPath};
        //TRACEV_2(_itemCfg,_mags);
        [_mags] call FUNC(updateLibary);
        private _temp = [
            [_cfg] call EFUNC(common,getModPicture),
            If (count _modName > 20) then {_modName select [0,20]} else {_modName},
            getText(_cfg>>"picture"),
            getText(_cfg>>"displayName"),
            _mags
        ];
        HASH_SET(GVAR(libary),_itemCfg,_temp);
    };
    nil
} count _itemlist;

_itemlist
