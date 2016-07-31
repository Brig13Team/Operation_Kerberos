/*
    Author: Dorbedo
    
    Description:
        displays message global
    
    Parameter(s):
        0 : STRING - Title
        1 : STRING - Message
		2 : STRING - Color
    
*/
#include "script_component.hpp"
[QGVAR(message),_this] call CBA_fnc_globalEvent;
