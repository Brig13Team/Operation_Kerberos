/*
    Author: Dorbedo

    Description:
        Handles the Tasks

    Parameter(s):
        0 : SCALAR              - Checkintervall in seconds (minimum 3 seconds, maximum 120 seconds)
        1 : SCALAR or STRING    - (Optional) - Taskname or TaskID (used for cancel, sucess, fail)
        1 : CODE                - Checkcondition
        2 : ARRAY               - Arguments passed to Checkcondition
        4 : CODE                - Condition for Sucess
        5 : CODE                - Code on Sucess
        6 : CODE                - Code on Failure
        7 : ARRAY               - Arguments passed to Sucess/Failure
        8 : CODE                - Code executed in each Loop
        9 : ARRAY               - Arguments passed into LoopCode

    Please Note:

        #define INTERVALL 30
        #define TASK ""
        #define CONDITION {_a ={!(alive _x)}count (_this select 0);If (_a > ((count _target)-4)) then {true}else{false};}
        #define CONDITIONARGS [_target]
        [30,TASK,CONDITION,CONDITIONARGS] call FUNC(taskhandler);


        [INTERVALL,TASK,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS,ONFAILURE,SUCESSARG,ONLOOP,ONLOOPARGS] call FUNC(taskhandler);

    Return
    BOOL - isSucess

*/
#include "script_component.hpp"
SCRIPT(taskhandler);
params[
        ["_intervall",30,[0]],
        ["_task","",[0,""]],
        ["_condition",{true},[{}]],
        ["_conditionArgs",[],[[]]],
        ["_conditionSucess",{true},[{}]],
        ["_onSucess",{},[{}]],
        ["_onFailure",{},[{}]],
        ["_args",[],[[]]],
        ["_afterCheck",{},[{}]],
        ["_afterCheckArgs",[],[[]]]
    ];
private["_isTask","_cancel","_taskhandling","_state"];
_cancel=false;
/// Optional: Taskname/taskID
If (IS_SCALAR(_task)) then {
    _isTask=true;
}else{
    If (_task isEqualTo "") then {_isTask=false;}else{_isTask=true;};
};
ISNILS(taskcancel,false);
/// set intervall
_intervall = (_intervall max 3)min 120;

_taskhandling=false;
while {!_taskhandling} do {
    _taskhandling = _conditionArgs call _condition;
    _afterCheckArgs call _afterCheck;
    uiSleep _intervall;
    /// Exit if Admin wants to stop
    If (taskcancel) then {_cancel=true;};
    /// Exit if Parent has finished
    If (_isTask) then {
        _state = [_task] call BIS_fnc_taskState;
        If (_state in ["CANCELED","SUCCEEDED","FAILED"]) then {_cancel=true;};
    };
    CHECK(_cancel)
};
/// resets the canceled state of the task
If (_cancel) exitwith {
    If (_isTask) then {[_task,"CANCELED",false] spawn BIS_fnc_taskSetState;};
    false
};
/// Checks if task is Sucess
If (_args call _conditionSucess) then {
    _args call _onSucess;
    If (_isTask) then {[_task,"SUCCEEDED",false] spawn BIS_fnc_taskSetState;};
    true
}else{
    _args call _onFailure;
    If (_isTask) then {[_task,"FAILED",false] spawn BIS_fnc_taskSetState;};
    false
};