/*
    Author: iJesuz

    Description:
        Cancel all active Tasks

    Parameter(s):
        -

    Return:
        -

*/
#include "script_component.hpp"

private _conditions = +GVAR(conditions);
GVAR(conditions) = [];

{
    private _args = _x select 1;

    [_args, "Canceled"] call FUNC(taskmanager_setState);
} forEach _conditions;
