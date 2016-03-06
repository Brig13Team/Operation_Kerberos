/*
    Author: Dorbedo
    
    Description:
        postinit server
*/
#include "script_component.hpp"
waitUntil {!(isNil QGVARMAIN(playerside))};
[] spawn FUNC(spawn_createlist);