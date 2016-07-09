/*
    Author: iJesuz

    Description:
        initialize everything

    Parameter(s):
        -

    Return:
        -

*/
#include "script_component.hpp"

GVAR(next_mission)  = call EFUNC(taskmanager,choose_mission);
GVAR(next_location) = call EFUNC(taskmanager,choose_location);
GVAR(task_counter)  = 0;
GVAR(conditions)    = [];

private _handle = [{
    private _finished = [];
    private _x2 = _x;

    {
        private _func = _x select 0;
        private _args = _x select 1;

        private _ret  = _args call _func;
        if (_ret in ["Succeeded","Failed"]) then {
            _finished pushBack (+_x append _ret);
        };

        _x2 set [2, diag_tickTime];
    } forEach +GVAR(conditions);

    GVAR(conditions) = GVAR(conditions) - _finished;

    _finished spawn {
        {
            private _args = _x select 1;
            private _taskID = _args select 0;
            private _state = _x select 2;

            [_taskID, _state] call EFUNC(taskmanager,setState);

            ["MISSION_ENDED", [_taskID, _state]] call CBA_fnc_globalEvent;
        } forEach _this;
    }
}, 30, []] call CBA_fnc_addPerFrameHandler;

GVAR(PFH_handle) = _handle;
