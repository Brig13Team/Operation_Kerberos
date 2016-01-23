/*
    Author: Dorbedo
    
    Description:
        postinit server
*/
#include "script_component.hpp"

[{ [] call EFUNC(common,headless) } , 30, [] ] call CBA_fnc_addPerFrameHandler;