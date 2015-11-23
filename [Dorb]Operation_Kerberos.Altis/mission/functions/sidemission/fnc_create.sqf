/*
	Author: Dorbedo
	
	Description:
		creates mainmission
	
*/
#include "script_component.hpp"
SCRIPT(create);
params[["_taskMAIN","",[""]],["_positionMain",[],[[]]],["_task","",[""]],["_position",[],[[]]],["_taskID","",[""]],["_delayReveal",1,[0]]];
TRACEV_4(_taskMAIN,_task,_position,_taskID);


CHECK(true)
private ["_taskname","_taskdesc","_tasktype","_taskpic"];
_taskname = getText(missionconfigfile>>"missions_config">>"main">>_taskMAIN>>"sidemissions">>_task>>"task">>"name");
_taskdesc = getText(missionconfigfile>>"missions_config">>"main">>_taskMAIN>>"sidemissions">>_task>>"task">>"description");
_tasktype = getText(missionconfigfile>>"missions_config">>"main">>_taskMAIN>>"sidemissions">>_task>>"task">>"tasktype");
_taskmark = getText(missionconfigfile>>"missions_config">>"main">>_taskMAIN>>"sidemissions">>_task>>"task">>"taskmarker");
_taskpic = getText(missionconfigfile>>"CfgTaskTypes">>_tasktype>>"icon");

TRACEV_5(_position,_taskname,_taskdesc,_tasktype,_taskpic);
private ["_temp","_taskarray","_locations","_type"];
_temp = [];
_type = getText(missionconfigfile>>"missions_config">>"main">>_taskMAIN>>"sidemissions">>_task>>"type");

CHECK(_locations isEqualTo [])

_temp = switch (_type) do {
	case "konvoi" : 		{[_position,_positionMain] call FUNC(sidemission_konvoi);};
	
	
	
	
	
	default {ERROR(FORMAT_1("FEHLENDER TASK: %1",_task));[]};
};
CHECK(_temp isEqualTo [])
_taskarray = [10,format["%1_%2",_taskID,_task]];
_taskarray append _temp;

//// delay
uisleep (_delayReveal max 1);
private "_state";
_state = [_taskMAIN] call BIS_fnc_taskState;
If ((_state in ["CANCELED","SUCCEEDED","FAILED"])||(taskcancel)) exitWith {true;};

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
private ["_task_desc","_task_name"];
_task_name = localize(format[LSTRING(TASKNAME_BLANK),toUpper(_task)]);
_task_desc = localize(format[LSTRING(TASKDESC_BLANK),toUpper(_task)]);
[_task_name,[_task_desc],_taskpic,true] spawn EFUNC(interface,disp_info_global);

/// taskhandler
private "_sucess";
_sucess = _taskarray call FUNC(taskhandler);

/// display finished message
if (_sucess) then {
	[_task_name,[LSTRING(FINISHED)],_taskpic,true] spawn EFUNC(interface,disp_info_global);
}else{
	[_task_name,[LSTRING(FAILED)],_taskpic,true] spawn EFUNC(interface,disp_info_global);
};

