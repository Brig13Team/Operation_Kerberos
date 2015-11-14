/*
	Author: Dorbedo
	
	Description:
		Selects Mission
	
	Parameter(s):
		0 : STRING	- TASKID
	
*/
#include "script_component.hpp"
SCRIPT(choose);
params [["_taskID",format["NOTNUMMER%1",random 1000000],[""]]];
TRACEV_1(_taskID);

private ["_taskarray","_armys","_army","_config","_task"];
_taskarray = [];
_armys = [];
_config = missionconfigfile>>"missions_config">>"main";
{
	_taskarray pushBack [configname _x,getNumber(_x>>"probability")];
}forEach _config;

_task = ([_taskarray,1] call EFUNC(common,sel_array_weighted))select 0;

/// choose the army
_armys = getArray(missionconfigfile>>"missions_config">>"main">>_task>>"armys");
_army = ([_armys,1] call EFUNC(common,sel_array_weighted))select 0;
[_army] call EFUNC(spawn,army_set);

/// choose the position
private ["_positions","_positiontype","_position"];
_positiontype = getArray(missionconfigfile>>"missions_config">>"main">>_task>>"locations");
_positions = missionnamespace getVariable [_positiontype,[]];
CHECK(_positions isEqualTo [])
_position = _position SELRND;

_distance = getnumber(missionconfigfile>>"missions_config">>"main">>_task>>"locations");

[_task,_position] spawn FUNC(choose_side);


/// TODO - make a generic function
switch (_task) do {
	case "scarab" : {[_position,_distance,_task] call FUNC(main_scarab);};
	case "prototype" : {[_position,_distance,_task] call FUNC(main_prototype);};
	case "tower" : {[_position,_distance,_task] call FUNC(main_tower);};
	case "device" : {[_position,_distance,_task] call FUNC(main_device);};
	case "emp" : {[_position,_distance,_task] call FUNC(main_emp);};
	case "clear" : {[_position,_distance,_task] call FUNC(main_clear);};
	case "hostage" : {[_position,_distance,_task] call FUNC(main_hostage);};
	case "kill" : {[_position,_distance,_task] call FUNC(main_kill);};
	case "intel" : {[_position,_distance,_task] call FUNC(main_intel);};
	case "weaponcaches" : {[_position,_distance,_task] call FUNC(main_weaponcaches);};
};

[_position,_task] call FUNC(rtb);