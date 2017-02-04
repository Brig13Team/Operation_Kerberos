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

THIS = HASH_CREATE;
THIS_SET("next_mission",  "");
THIS_SET("next_location", "");
THIS_SET("task_counter",  0);
THIS_SET("missions",      []);

[] call FUNC(taskmanager_handle);
