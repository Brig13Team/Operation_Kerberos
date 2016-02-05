/*
    Author: Dorbedo
    
    Description:
        postinit client
*/
#include "script_component.hpp"
QEGVAR(mission,endzeit) addPublicVariableEventHandler {[] spawn FUNC(disp_timer)};
[] spawn FUNC(disp_timer);

[] call FUNC(teleport_init);
[] call FUNC(spawn_init);
[] call FUNC(crate_init);