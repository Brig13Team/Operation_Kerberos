/*
    Author: iJesuz

    Description:
        set task state

    Parameter(s):
        0 : STRING  - parent TaskID
        1 : STRING  - child TaskID
        2 : STRING  - state

    Return:
        -
*/
#include "script_component.hpp"

_this params [["_parent", "", ["",[]]], ["_child", "", ["",[]]], ["_state", "Assigned", [""]]];

if !THIS_HASKEY(_parent) exitWith { -2 };
if !HASH_HASKEY(THIS_GET(_parent), _child) exitWith { -2 };

[_mission, HASH_GET(THIS_GET(_parent), _child), _state] call FUNC(taskmanager___setState);
