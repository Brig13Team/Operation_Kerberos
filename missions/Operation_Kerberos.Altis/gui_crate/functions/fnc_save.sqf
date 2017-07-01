/*
    Author: Dorbedo

    Description:
        comunicate with save


*/
#define INCLUDE_GUI
#include "script_component.hpp"
CHECK(!hasInterface)
params[["_isSave",true,[true]]];
private "_return" ;
If (_isSave) exitWith {
    _return = [GVAR(current_boxid),GVAR(current)];
    ["CrateSpawn",true,_return] call EFUNC(gui_save,OpenMenu);
};
["CrateSpawn",false] call EFUNC(gui_save,OpenMenu);
waitUntil{(!ctrlVisible IDC_SAVE_BTTN1)};
If (isNil QEGVAR(gui_save,current)) exitWith {};
If (EGVAR(gui_save,current) isEqualTo []) exitWith {};
_return = EGVAR(gui_save,current);
GVAR(current_boxid) = _return select 0;
GVAR(current) = _return select 1;
[1] call FUNC(filter);
