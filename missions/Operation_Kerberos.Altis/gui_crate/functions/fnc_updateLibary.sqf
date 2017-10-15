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
        private _temp = [
            [_x] call EFUNC(common,getModPicture),
            [_x] call EFUNC(common,getMod),
            getText(_x>>"picture"),
            getText(_x>>"displayName")
        ];
        HASH_SET(GVAR(libary),_itemCfg,_temp);
    };
    nil
} count _itemlist;
