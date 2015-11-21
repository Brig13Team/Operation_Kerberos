/*
	Author: Dorbedo
	
	Description:
		creates mainmission
	
*/
#define DEBUG_MODE_FULL
#include "script_component.hpp"
SCRIPT(create);
params[["_tasktype","",[[]]],["_centerposition",[],[[]]],["_distance",1000,[0]],["_taskID","",[""]]];
LOG_4(_tasktype,_centerposition,_distance,_taskID);
private "_position";

_position = [_centerposition,_distance,0] call EFUNC(common,pos_random);
LOG_1(_position);
private ["_taskname","_taskdesc","_tasktype","_taskpic"];
_taskname = getText(missionconfigfile>>"missions_config">>"main">>_task>>"task">>"name");
_taskdesc = getText(missionconfigfile>>"missions_config">>"main">>_task>>"task">>"description");
_tasktype = getText(missionconfigfile>>"missions_config">>"main">>_task>>"task">>"tasktype");
_taskmark = getText(missionconfigfile>>"missions_config">>"main">>_task>>"task">>"taskmarker");
_taskpic = getText(missionconfigfile>>"CfgTaskTypes">>_tasktype>>"icon");

TRACEV_5(_position,_taskname,_taskdesc,_tasktype,_taskpic);
private ["_temp","_taskarray"];
_temp = [];
_temp = switch (_task) do {
	case "scarab" : 		{[_position] call FUNC(mainmission_scarab);};
	case "prototype" : 		{[_position] call FUNC(mainmission_prototype);};
	case "tower" : 			{[_position] call FUNC(mainmission_tower);};
	case "device" : 		{[_position] call FUNC(mainmission_device);};
	case "emp" : 			{[_position] call FUNC(mainmission_emp);};
	//case "clear" : 			{[_position] call FUNC(mainmission_clear);};
	//case "hostage" : 		{[_position] call FUNC(mainmission_hostage);};
	//case "kill" : 			{[_position] call FUNC(mainmission_kill);};
	//case "intel" : 			{[_position] call FUNC(mainmission_intel);};
	//case "weaponcaches" : 	{[_position] call FUNC(mainmission_weaponcaches);};
	//case "dronecommando" : 	{[_position] call FUNC(mainmission_dronecommando);};
	//case "specops" : 		{[_position] call FUNC(mainmission_specops);};
	//case "outpost" : 		{[_position] call FUNC(mainmission_outpost);};
	//case "radarsetup" : 	{[_position] call FUNC(mainmission_radarsetup);};
	default {LOG_1(_task);[]};
};
CHECK(_temp isEqualTo [])
_taskarray = [10,_taskID];
_taskarray append _temp;


///// spawn units

/// TODO
private ["_amount"];
_amount = 12;

[_centerposition,1200,_amount] call EFUNC(spawn,patrol_create);
//[_centerposition,_amount] call EFUNC(spawn,strikeforce_create);
//[_centerposition,_amount] call EFUNC(spawn,defence_create);

//[] call EFUNC(ai,hq_init_mission);



//// Task creation
[
	_taskID,
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

