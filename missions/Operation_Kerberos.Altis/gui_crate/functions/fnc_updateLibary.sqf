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

#include "script_component.hpp"

params [["_itemlist",[],[[]]]];

{
    private _itemCfg = _x;
    If !(HASH_HASKEY(GVAR(libary),_itemCfg)) then {
        TRACEV_1(_itemCfg);
        private _cfg = [_itemCfg,configFile] call BIS_fnc_configPath;
        private _modName = [_cfg] call EFUNC(common,getModName);
        private _mags = getArray(_cfg >> "magazines");
        _mags = _mags apply {[_x,""] call BIS_fnc_configPath};
        private _temp = [
            [_cfg] call EFUNC(common,getModPicture),
            If (count _modName > 17) then {_modName select [0,17]} else {_modName},
            getText(_cfg>>"picture"),
            getText(_cfg>>"displayName"),
            _mags
        ];
        HASH_SET(GVAR(libary),_itemCfg,_temp);
    };
    nil
} count _itemlist;

_itemlist
