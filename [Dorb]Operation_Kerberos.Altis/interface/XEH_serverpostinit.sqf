/*
    Author: Dorbedo
    
    Description:
        postinit server
*/
#include "script_component.hpp"
SCRIPT(XEH_SERVERPOSTINIT);
waitUntil {!(isNil QGVARMAIN(playerside))};
[] spawn FUNC(spawn_createlist);