/*
    Author: Dorbedo

    Description:
        Opens the crate-interface

*/
#include "script_component.hpp"
SCRIPT(OpenMenu);
[] call FUNC(crate_createlists);

if (isnil QGVAR(crate_current)) then {
    GVAR(crate_current) = [[],[],[],[],[],[]];
};

if (isnil QGVAR(crate_current_boxid)) then {
    GVAR(crate_current_boxid) = 0;
};

createDialog QGVAR(crate);