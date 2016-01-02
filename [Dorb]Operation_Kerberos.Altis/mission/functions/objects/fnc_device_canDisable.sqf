/*
    Author: Dorbedo
    
    Description:
        
    
*/
#include "script_component.hpp"
SCRIPT(canDisable);

_this params ["_target"];

_target getVariable [QGVAR(enabled),false];

