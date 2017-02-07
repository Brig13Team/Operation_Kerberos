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

if (THIS_HASKEY(_parent)) then {
    private _mission = THIS_GET(_parent);
    if (HASH_HASKEY(_mission, _child)) then {
        [_mission, HASH_GET(_mission, _child), _state] call FUNC(taskmanager___setState);
    };
};
