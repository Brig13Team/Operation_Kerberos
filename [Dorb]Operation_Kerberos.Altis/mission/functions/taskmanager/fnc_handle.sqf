/*
    Author: iJesuz, Dorbedo

    Description:
        taskmanager handle

    Parameter(s):
        -

    Returns:
        -

 */
#include "script_component.hpp"

// copy is needed because FUNC(taskmanager_setState) modifies the global state
private _missions = +THIS_GET("missions");

for "_i" from (count _missions) - 1 do {
    if (THIS_HASKEY(_x)) then {
        private _mission = THIS_GET(_x);
        private _fnc = HASH_GET(_mission, "condition_fnc");

        private _ret = [_mission] call (missionNamespace getVariable [_fnc, {}]);
        if (_ret in ["Succeeded","Canceled","Failed"]) then {
            [_x, _state] call FUNC(taskmanager_setState);
        } else {
            // TODO: handle sidemissions
        };
    };
};

[{
    [] call FUNC(taskmanager_handle);
}, [], CHECK_INTERVALL] call CBA_fnc_waitAndExecute;
