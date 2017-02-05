/*
    Author: iJesuz

    Description:
        create a new task

    Parameter(s):
        0 : HASH    - mission hash

    Return:
        -
*/
#include "script_component.hpp"

_this params [["_mission"]];

[__THIS, _mission] call FUNC(taskmanager___add);
