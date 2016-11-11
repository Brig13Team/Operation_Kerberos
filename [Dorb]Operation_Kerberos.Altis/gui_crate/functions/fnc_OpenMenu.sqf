/*
    Author: Dorbedo

    Description:
        Opens the crate-interface

*/
#include "script_component.hpp"

GVAR(currentSpawn) = objNull;
{
    If ((_x distance player)<(GVAR(currentSpawn) distance _player)) then {
        GVAR(currentSpawn) = _x;
    };
} forEach GVAR(cratelogics);

[] call FUNC(createlists);

if (isnil QGVAR(current)) then {
    GVAR(current) = [[],[],[],[],[],[]];
};

if (isnil QGVAR(current_boxid)) then {
    GVAR(current_boxid) = 0;
};

createDialog QAPP(dialog);
