/*
    Author: Dorbedo
    
    Description:
        creates mainmission
    
*/
#include "script_component.hpp"
SCRIPT(create);
params[["_taskMAIN","",[""]],["_positionMain",[],[[]]],["_task","",[""]],["_position",[],[[]]],["_taskID","",[""]],["_delayReveal",1,[0]]];
TRACEV_4(_taskMAIN,_task,_position,_taskID);

private _taskname = getText(missionconfigfile>>"missions_config">>"main">>_taskMAIN>>"sidemissions">>_task>>"task">>"name");
private _taskdesc = getText(missionconfigfile>>"missions_config">>"main">>_taskMAIN>>"sidemissions">>_task>>"task">>"description");
private _tasktype = getText(missionconfigfile>>"missions_config">>"main">>_taskMAIN>>"sidemissions">>_task>>"task">>"tasktype");
private _taskmark = getText(missionconfigfile>>"missions_config">>"main">>_taskMAIN>>"sidemissions">>_task>>"task">>"taskmarker");
private _taskpic = getText(missionconfigfile>>"CfgTaskTypes">>_tasktype>>"icon");

TRACEV_5(_position,_taskname,_taskdesc,_tasktype,_taskpic);
private _temp = [];
private _type = getText(missionconfigfile>>"missions_config">>"main">>_taskMAIN>>"sidemissions">>_task>>"type");

_temp = [_position,_positionMain] call (missionNamespace getVariable [format ["%1_%2",QUOTE(DOUBLES(GVAR(fnc),PART)),_type],{}]);

CHECKRET(isNil "_temp",[]);
CHECKRET(_temp isEqualTo [],ERROR(FORMAT_1("Missing Sidetaks %1",_type));[]);

private _taskarray = [10,format["%1_%2",_taskID,_task]];
_taskarray append _temp;

//// delay
uisleep (_delayReveal max 1);
private _state = [_taskMAIN] call BIS_fnc_taskState;
If ((_state in ["CANCELED","SUCCEEDED","FAILED"])||(taskcancel)) exitWith {true;};
If ((_taskarray select 3) call (_taskarray select 2)) exitWith {false};

//// Task creation
[
    [_taskID,format["%1_%2",_taskID,_task]],
    true,
    [_taskdesc,_taskname,_taskmark],
    _centerposition,
    "AUTOASSIGNED",
    10,
    false,
    true,
    _tasktype
] spawn BIS_fnc_setTask;

/// workaround for localisation on player
private _task_name = localize(format[LSTRING(TASKNAME_BLANK),toUpper(_type)]);
private _task_desc = localize(format[LSTRING(TASKDESC_BLANK),toUpper(_type)]);
[_task_name,[_task_desc],_taskpic,true] spawn EFUNC(interface,disp_info_global);

/// taskhandler call & display finished message
if (_taskarray call FUNC(taskhandler)) then {
    [_task_name,[LSTRING(FINISHED)],_taskpic,true] spawn EFUNC(interface,disp_info_global);
}else{
    [_task_name,[LSTRING(FAILED)],_taskpic,true] spawn EFUNC(interface,disp_info_global);
};
