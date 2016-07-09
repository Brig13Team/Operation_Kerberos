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

GVAR(next_mission)  = [] call FUNC(taskmanager_choose_mission);
GVAR(next_location) = [GVAR(next_mission)] call FUNC(taskmanager_choose_location);
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
            _finished pushBack _x;

            ((+_x) + [_ret]) spawn {
                _this params ["_func","_args","_state"];
                _taskNumber = _args;

                [_taskNumber, _state] call FUNC(taskmanager_setState);

                [QGVAR(FINISHED), [_taskNumber, _state]] call CBA_fnc_globalEvent;
            }
        };

        _x2 set [2, diag_tickTime];
    } forEach +GVAR(conditions);

    GVAR(conditions) = GVAR(conditions) - _finished;
}, 30, []] call CBA_fnc_addPerFrameHandler;

GVAR(PFH_handle) = _handle;
