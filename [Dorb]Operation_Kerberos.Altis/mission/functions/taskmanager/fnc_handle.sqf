/*
    Author: iJesuz, Dorbedo

    Description:
        taskmanager handle

    Parameter(s):
        -

    Return:
        -
*/
#include "script_component.hpp"

[__THIS] call FUNC(taskmanager___handle);

[{
    [] call FUNC(taskmanager_handle);
}, [], CHECK_INTERVALL] call CBA_fnc_waitAndExecute;
