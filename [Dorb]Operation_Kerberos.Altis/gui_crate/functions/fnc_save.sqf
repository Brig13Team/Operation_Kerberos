/*
    Author: Dorbedo

    Description:
        comunicate with save
    
    
*/
#include "script_component.hpp"
CHECK(!hasInterface)
params[["_isSave",true,[true]]];
private "_return" ;
If (_isSave) exitWith {
    _return = [GVAR(crate_current_boxid),GVAR(crate_current)];
    ["CrateSpawn",true,_return] call FUNC(save_OpenMenu);
};
["CrateSpawn",false] call FUNC(save_OpenMenu);
waitUntil{(!ctrlVisible 600243)};
If (isNil QGVAR(save_current)) exitWith {};
If (GVAR(save_current) isEqualTo []) exitWith {};
_return = GVAR(save_current);
GVAR(crate_current_boxid) = _return select 0;
GVAR(crate_current) = _return select 1;
[1] call FUNC(crate_filter);