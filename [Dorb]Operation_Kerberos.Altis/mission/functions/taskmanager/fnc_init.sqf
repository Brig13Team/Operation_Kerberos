/*
    Author: iJesuz

    Description:
        initialize everything

    Parameter(s):
        -

    Return:
        -

*/
#include "script_component.hpp"

#define DELAY 30

GVAR(next_mission)  = [] call FUNC(taskmanager_choose_mission);
GVAR(next_location) = [GVAR(next_mission)] call FUNC(taskmanager_choose_location);
GVAR(task_counter)  = 0;
GVAR(conditions)    = [];

GVAR(PFH_handle) = [FUNC(taskmanager_handle), DELAY, []] call CBA_fnc_addPerFrameHandler;
