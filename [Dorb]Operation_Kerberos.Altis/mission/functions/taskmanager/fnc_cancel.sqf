/*
    Author: iJesuz

    Description:
        Cancel active Task
        (All Child Tasks will be killed too!)

    Parameter(s):
        0 : NUMBER or [NUMBER,NUMBER]   - Task to cancel

    Return:
        -

*/
#include "script_component.hpp"

_this params [["_number",-1,[0,[]]]];

if (typeName _number == typeName 0) then {
    private _tasksToKill = [];

    {
        _args = _x select 1;

        if (typeName _number == typeName 0) then {
            if ((typeName _args == typeName []) && {_args select 0 == _number}) then {
                [_args, "Canceled"] call FUNC(taskmanager_setState);
                GVAR(conditions) = GVAR(conditions) - [_x];
            };
            if ((typeName _args isEqualTo []) && {_args isEqualTo _number}) then {
                [_args, "Canceled"] call FUNC(taskmanager_setState);
            };
        } else {
            if ((typeName _args == typeName []) && {_args isEqualTo _number}) then {
                [_args, "Canceled"] call FUNC(taskmanager_setState);
                GVAR(conditions) = GVAR(conditions) - [_x];
            };
        };
    } forEach +GVAR(conditions);
} else {
    {
        private _args = _x select 1;

        if ((typeName _args == typeName []) && {_args isEqualTo _number}) exitWith {
            [_args, "Canceled"] call FUNC(taskmanager_setState);
            GVAR(conditions) = GVAR(conditions) - [_x];
        };
    } forEach +GVAR(conditions);
};
