/*
    Author: iJesuz

    Description:
        set task state

    Parameter(s):
        0 : STRING  - TaskID
        1 : STRING  - state

    Return:
        -
*/
#include "script_component.hpp"

_this params [["_name", "", ["",[]]], ["_state", "Assigned", [""]]];

if !THIS_HASKEY(_name) exitWith { -2 };
[__THIS, THIS_GET(_name), _state] call FUNC(taskmanager___setState);
