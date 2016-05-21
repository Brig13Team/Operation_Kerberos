/*
    Author: Dorbedo
    
    Description:
        postinit
*/
#include "script_component.hpp"
If (!hasInterface) then {
    [
        "teamkill",
        {diag_log text _this}
    ] call CBA_fnc_addEventHandler;
};