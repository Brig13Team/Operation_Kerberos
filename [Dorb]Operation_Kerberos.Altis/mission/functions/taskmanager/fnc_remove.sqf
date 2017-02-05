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

if (THIS_HASKEY(_name)) then {
    [__THIS, _name] call FUNC(taskhandler___remove);
};
