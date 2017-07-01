/*
    Author: iJesuz

    Description:
        internal function
        (cancel all missions)

    Parameter(s):
        0 : HASH    - taskhandler

    Return:
        -
*/
#include "script_component.hpp"

_this params ["_taskhandler"];

private _missions = +HASH_GET(_taskhandler, "missions");
HASH_SET(_taskhandler, "missions", []);

TRACEV_2(_taskhandler, _missions);

{
    private _mission = HASH_GET(_taskhandler, _x);

    private _taskID = HASH_GET(_mission, "BIS_taskID");
    HASH_SET(_mission, "state", "Canceled");
    [_taskID,nil,nil,nil,"Canceled",nil,false] call BIS_fnc_setTask;

    [_mission] call FUNC(taskmanager___cancelAll);
} forEach _missions;
