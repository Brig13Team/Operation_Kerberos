/*
    Author: Dorbedo
    
    Description:
        postinit
*/
#include "script_component.hpp"
If (!hasInterface) then {
    [
        QGVAR(teamkill),
        {diag_log text _this}
    ] call CBA_fnc_addEventHandler;
};