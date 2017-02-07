/*
    Author: iJesuz

    Description:
        create a new child task

    Parameter(s):
        0 : STRING  - parent task
        1 : HASH    - mission hash

    Return:
        -
*/
#include "script_component.hpp"

_this params [["_parent", "", [""]], "_mission"];

if (THIS_HASKEY(_parent)) then {
    [THIS_GET(_parent), _mission] call FUNC(taskmanager___add);
};
