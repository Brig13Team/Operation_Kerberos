/*
 * Author: Dorbedo
 * removes the radio out of getUnitloadout
 *
 * Arguments:
 * none
 *
 * Return Value:
 * none
 *
 *
 * Public: Yes
 */
#include "script_component.hpp"
LOG("Cleaning Respawn loadout");
_this params [
    ["_loadout", [[],[],[],[],[],[],"","",[],[]], [[]] ]
    ];

private _fnc_clean = {
    _this params ["_gear","_inventory"];
    {
        private _value = _x;
        private _classnamearray = (_value select 0) splitString "_";
        If (((_classnamearray select 0) isEqualTo "ACRE")&&{((_classnamearray select 1) in ["PRC148","PRC152","PRC117F","PRC77","PRC343"])&&(count _classnamearray > 2)}) then {
            _classnamearray resize 2;
            _value set [0,_classnamearray joinString "_"];
            _inventory set [_forEachIndex,_value];
        };
    } forEach _inventory;
    [_gear,_inventory];
};

{
    If !(_x isEqualTo []) then {
        _x = _x call _fnc_clean;
    };
} forEach [(_loadout select 3),(_loadout select 4),(_loadout select 5)];

_loadout;
