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

#define DELAY 30

GVAR(next_mission)  = [] call FUNC(taskmanager_choose_mission);
GVAR(next_location) = [GVAR(next_mission)] call FUNC(taskmanager_choose_location);
GVAR(task_counter)  = 0;
GVAR(conditions)    = [];

private _handle = [{
    private _x2 = _x;

    {
        private _func = _x select 0;
        private _args = _x select 1;
        // private _taskNumber = _x select 2;

        private _ret  = _args call (missionNamespace getVariable [_func,{}]);
        if (_ret in ["Succeeded","Canceled","Failed"]) then {
            ((+_x) + [_ret]) spawn {
                _this params ["_func","_args","_taskNumber","_state"];

                [_taskNumber, _state] call FUNC(taskmanager_setState);

                if (typeName _taskNumber == typeName 0) then {
                    [QGVAR(finished), [_taskNumber, _state]] call CBA_fnc_globalEvent;
                } else {
                    [QGVAR(finished_side), [_taskNumber, _state]] call CBA_fnc_globalEvent;
                };
            }
        };

        _x2 set [2, diag_tickTime + DELAY];
    } forEach +GVAR(conditions);
}, DELAY, []] call CBA_fnc_addPerFrameHandler;

GVAR(PFH_handle) = _handle;
