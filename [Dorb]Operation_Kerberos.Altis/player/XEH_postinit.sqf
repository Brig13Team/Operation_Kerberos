/*
    Author: Dorbedo

    Description:
        postinit
*/
#include "script_component.hpp"

["Initialize"] call BIS_fnc_dynamicGroups;

If (!hasInterface) then {
    [
        QGVAR(teamkill),
        {diag_log text _this}
    ] call CBA_fnc_addEventHandler;
};
