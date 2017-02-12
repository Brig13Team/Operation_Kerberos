/*
    Author: iJesuz

    Description:
        delete a task

    Parameter(s):
        0 : STRING  - parent task
        1 : STRING  - child task

    Return:
        -
*/
#include "script_component.hpp"

_this params [["_parent", "", [""]], ["_child", "", [""]]];

if !THIS_HASKEY(_parent) exitWith { -2 };
if !HASH_HASKEY(THIS_GET(_parent),_child) exitWith { -2 };

[THIS_GET(_parent), _child] call FUNC(taskmanager___remove);
