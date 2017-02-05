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

if (THIS_HASKEY(_parent)) then {
    private _mission = THIS_GET(_parent);
    if (HASH_GET(_mission, "_child")) then {
        [_mission, _child] call FUNC(taskmanager___remove);
    }
};
