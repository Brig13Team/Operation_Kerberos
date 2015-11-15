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
private ["_positions","_positiontypes","_position"];
_positiontypes = getArray(missionconfigfile>>"missions_config">>"main">>_task>>"location">>"areas");
_positions = [];
{
	_positions pushBack (missionnamespace getVariable [_x,[]]);
}forEach _positiontypes;
CHECK(_positions isEqualTo [])
_position = _position SELRND;

_distance = getnumber(missionconfigfile>>"missions_config">>"main">>_task>>"location">>"distance");

[_task,_position] spawn FUNC(choose_side);


[_task,_position,_distance,_taskID] call FUNC(main_create);

[_position,_task] call FUNC(rtb);