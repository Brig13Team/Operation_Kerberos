/*
    Author: Dorbedo
    
    Description:
        postinit client
*/
#include "script_component.hpp"
QEGVAR(mission,endzeit) addPublicVariableEventHandler {[] spawn FUNC(disp_timer)};
[] spawn FUNC(disp_timer);
["dispInfo",{_this spawn FUNC(disp_info)}] call CBA_fnc_addEventHandler;
["dispMessage",{_this spawn FUNC(disp_message)}] call CBA_fnc_addEventHandler;
[] call FUNC(teleport_init);
[] call FUNC(spawn_init);
[] call FUNC(crate_init);