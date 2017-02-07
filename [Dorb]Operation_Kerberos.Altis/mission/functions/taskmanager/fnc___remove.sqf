/*
    Author: iJesuz

    Description:
        internal function
        (remove mission from taskhandler)

    Parameter(s):
        0 : HASH    - taskhandler
        1 : STRING  - mission name

    Return:
        -
*/
#include "script_component.hpp"

_this params ["_taskhandler", "_name"];

HASH_SET(_taskhandler, "missions", HASH_GET(_taskhandler, "missions") - [_name]);

private _mission = HASH_GET(_taskhandler, _name);
{
    [_mission, _x] call FUNC(taskmanager___remove);
} forEach +HASH_GET(_mission, "missions");

HASH_REM(_taskhandler, _name);

// remove mission from Bohemia's system
private _taskID = HASH_GET(_mission, "BIS_taskID");
[_taskID] call BIS_fnc_deleteTask;
