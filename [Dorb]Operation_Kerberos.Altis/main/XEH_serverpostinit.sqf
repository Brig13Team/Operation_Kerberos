/*
    Author: Dorbedo
    
    Description:
        postinit server
*/
#include "script_component.hpp"
SCRIPT(XEH_SERVERPOSTINIT);
[{ [] call EFUNC(common,headless) } , 30, [] ] call CBA_fnc_addPerFrameHandler;