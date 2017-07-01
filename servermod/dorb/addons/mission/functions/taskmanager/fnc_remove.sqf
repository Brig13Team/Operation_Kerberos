/*
    Author: iJesuz

    Description:
        delete a task

    Parameter(s):
        0 : STRING  - task to remove

    Return:
        -
*/
#include "script_component.hpp"

_this params [["_name", "", [""]]];

if !THIS_HASKEY(_name) exitWith { -2 };
[__THIS, _name] call FUNC(taskmanager___remove);
