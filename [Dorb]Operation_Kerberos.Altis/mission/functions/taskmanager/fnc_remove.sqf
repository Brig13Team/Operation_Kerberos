/*
    Author: iJesuz

    Description:
        delete the task(s)

    Parameter(s):
        0 : STRING  - task(s) to remove

    Return:
        -

*/
#include "script_component.hpp"

_this params [["_name", "", ["",[]]]];

if (THIS_HASKEY(_name)) then {
    private _mission = THIS_GET(_name);
    THIS_SET("missions", THIS_GET("missions") - [_name]);

    {
        [_name,_x] call func(taskmanager_removeChild);
    } forEach HASH_GET(_mission,"sidemissions");

    THIS_REM(_name);
    [_name] call BIS_fnc_deleteTask;
};
