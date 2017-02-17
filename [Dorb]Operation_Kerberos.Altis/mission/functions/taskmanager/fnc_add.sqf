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

_this params ["_mission"];

if !(HASH_HASKEY(_mission,"type") &&
     HASH_HASKEY(_mission,"location") &&
     HASH_HASKEY(_mission,"state") &&
     HASH_HASKEY(_mission,"condition")) exitWith { -1 };

[__THIS, _mission] call FUNC(taskmanager___add);
