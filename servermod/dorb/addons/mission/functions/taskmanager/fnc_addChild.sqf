/*
    Author: iJesuz

    Description:
        create a new child task

    Parameter(s):
        0 : STRING  - parent task
        1 : HASH    - mission hash

    Return:
        STRING - mission name
*/
#include "script_component.hpp"

_this params [["_parent", "", [""]], "_mission"];

if !(HASH_HASKEY(_mission,"type") &&
     HASH_HASKEY(_mission,"state") &&
     HASH_HASKEY(_mission,"location") &&
     HASH_HASKEY(_mission,"condition")) exitWith { -1 };
if !(THIS_HASKEY(_parent)) exitWith { -2 };

[THIS_GET(_parent), _mission] call FUNC(taskmanager___add)
