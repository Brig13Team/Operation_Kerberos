/*
    Author: Dorbedo

    Description:
        Handles the Tasks

    Parameter(s):
        0 : SCALAR              - Checkintervall in seconds (minimum 3 seconds, maximum 120 seconds)
        1 : SCALAR or STRING    - (Optional) - Taskname or TaskID (used for cancel, sucess, fail)
        1 : CODE/STRING         - Checkcondition
        2 : ARRAY               - Arguments passed to Checkcondition
        4 : CODE/STRING         - Condition for Sucess
        5 : CODE/STRING         - Code on Sucess
        6 : CODE/STRING         - Code on Failure
        7 : ARRAY               - Arguments passed to Sucess/Failure
        8 : CODE/STRING         - Code executed in each Loop
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
_this params[
    ["_intervall",30,[0]],
    ["_task","",[0,""]],
    ["_condition",{true},[{},""]],
    ["_conditionArgs",[],[[]]],
    ["_conditionSucess",{true},[{},""]],
    ["_onSucess",{},[{},""]],
    ["_onFailure",{},[{},""]],
    ["_args",[],[[]]],
    ["_afterCheck",{},[{},""]],
    ["_afterCheckArgs",[],[[]]]
];
TRACEV_7(_intervall,_task,_condition,_conditionArgs,_conditionSucess,_onSucess,_onFailure);
TRACEV_3(_args,_afterCheck,_afterCheckArgs);
private _cancel=false;
/// Optional: Taskname/taskID
private "_isTask";
If (IS_SCALAR(_task)) then {
    _isTask=true;
}else{
    _isTask = If (_task isEqualTo "") then {false}else{true};
};
if (IS_STRING(_condition)) then {
    _condition = compile _condition;
};
if (IS_STRING(_conditionSucess)) then {
    _conditionSucess = compile _conditionSucess;
};
if (IS_STRING(_onSucess)) then {
    _onSucess = compile _onSucess;
};
if (IS_STRING(_onFailure)) then {
    _onFailure = compile _onFailure;
};
if (IS_STRING(_afterCheck)) then {
    _afterCheck = compile _afterCheck;
};
ISNILS(taskcancel,false);

If (_isTask) then {[_task] call FUNC(registertask);};

/// set intervall
_intervall = (_intervall max 3) min 120;

private _taskhandling=false;
while {!_taskhandling} do {
    _taskhandling = _conditionArgs call _condition;
    _afterCheckArgs call _afterCheck;
    uiSleep _intervall;
    /// Exit if Admin wants to stop
    If (taskcancel) then {_cancel=true;};
    /// Exit if Parent has finished
    If (_isTask) then {
        private _state = [_task] call BIS_fnc_taskState;
        If (_state in ["CANCELED","SUCCEEDED","FAILED"]) then {_cancel=true;};
    };
    CHECK(_cancel)
};
/// resets the canceled state of the task
If (_cancel) exitwith {
    If (_isTask) then {[_task,"CANCELED",false] spawn BIS_fnc_taskSetState;};
    ["MISSION_ENDED",[_task,"CANCELED"]] call CBA_fnc_globalEvent;
    false
};
/// Checks if task is Sucess
If (_args call _conditionSucess) then {
    _args call _onSucess;
    If (_isTask) then {[_task,"SUCCEEDED",false] spawn BIS_fnc_taskSetState;};
    ["MISSION_ENDED",[_task,"SUCCEEDED"]] call CBA_fnc_globalEvent;
    true
}else{
    _args call _onFailure;
    If (_isTask) then {[_task,"FAILED",false] spawn BIS_fnc_taskSetState;};
    ["MISSION_ENDED",[_task,"FAILED"]] call CBA_fnc_globalEvent;
    false
};
