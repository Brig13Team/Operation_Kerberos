/*
    Author: iJesuz

    Description:
        internal function
        (check mission conditions)

    Parameter(s):
        0 : HASH    - taskhandler

    Returns:
        -
*/
#include "script_component.hpp"

_this params ["_taskhandler"];

{
    private _mission   = HASH_GET(_taskhandler, _x);
    private _condition = HASH_GET(_mission, "condition");
    private _state     = [_mission] call (missionNamespace getVariable [_condition, {}]);

    [_taskhandler, _mission, _state] call FUNC(taskmanager___setState);
    [_mission] call FUNC(taskmanager___handle);
} forEach +HASH_GET(_taskhandler, "missions");
