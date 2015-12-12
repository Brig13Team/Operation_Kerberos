/*
    Author: Dorbedo

    Description:
        adds Action to spawner
    
    
*/
#include "script_component.hpp"
SCRIPT(addAction);
CHECK(!hasInterface)
[["<t size='1.5' shadow='2' color='#FF860F'>" +localize LSTRING(crate_header) +"</t>", {[]call FUNC(crate_OpenMenu);}, [], 5, false, true, "","alive _target and (getposatl player distance getposatl cratespawner) < 4"]] call CBA_fnc_addPlayerAction;