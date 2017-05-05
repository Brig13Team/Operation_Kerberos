/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the fastArsenalList
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      LOCATION - the fastArsenalListHash
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

GVAR(fastArsenalList) = [[],[]];

private _data = profilenamespace getvariable ["bis_fnc_saveInventory_data",[]];

private _id = GVAR(fastArsenalList) select 0;
private _loadout = GVAR(fastArsenalList) select 1;


for "_i" from 0 to (count _data - 1) step 2 do {
    private _name = _data select _i;
    private _inventory = + (_data select (_i + 1));
    _inventory resize 10;
    private _test = [_inventory] call FUNC(isRestrictedArray);
    TRACEV_3(_name,_test,_inventory);
    If ((GVAR(level)<1)||{!([_inventory] call FUNC(isRestrictedArray))}) then {
        private _index = count _id;
        _id set [_index,_name];
        _loadout set [_index,_inventory];
    };
};
