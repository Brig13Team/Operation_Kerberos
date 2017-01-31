/*
 *  Author: iJesuz, Dorbedo
 *
 *  Description:
 *      Taskmanager Handle
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
#ifndef DELAY
    #define DELAY 30
#endif


private _x2 = _x;
private _conditions = [];
{
    private _func = _x select 0;
    private _args = _x select 1;
    // private _taskNumber = _x select 2;

    private _ret  = _args call (missionNamespace getVariable [_func,{}]);
    TRACEV_3(_ret,_args,_func);
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
    } else {
        _conditions pushBack _x;
    };

    _x2 set [2, diag_tickTime + DELAY];
} forEach +GVAR(conditions);
GVAR(conditions) = +_conditions;
