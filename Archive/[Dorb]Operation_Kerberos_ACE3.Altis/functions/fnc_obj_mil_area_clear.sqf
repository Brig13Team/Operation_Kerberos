/*
	Author: Dorbedo

	Description:
	Creates Mission "Clear Area".
	

	Parameter(s):
		0 :	ARRAY - Position
		1 :	ARRAY - Ziele
		2 : STRING - Aufgabenname für Taskmaster
		
	Returns:
		None
*/
#include "script_component.hpp"
SCRIPT(obj_mil_clear);
CHECK(!isServer)

private["_radius","_list","_difficulty"];
LOG("Task_Create Clear Military");
PARAMS_3(_ort,_position,_task);

_radius = 1000;
_list=[];
_difficulty = call FM(dyn_difficulty);



//////////////////////////////////////////////////
////// Ziel erstellen						 /////
//////////////////////////////////////////////////

[_position] call FM(spawn_obj_mil);


//////////////////////////////////////////////////
////// Aufgabe erstellen 					 /////
//////////////////////////////////////////////////

[_task,true,[["STR_DORB_CLEAR_TASK_DESC",_ort],["STR_DORB_CLEAR_TASK",_ort],"STR_DORB_CLEAR"],_position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;

[-1,{[_this select 0,[format [localize (_this select 1),_this select 2]],_this select 3,_this select 4] spawn FM(disp_info);},["STR_DORB_CLEAR","STR_DORB_CLEAR_TASK",_ort,"data\icon\icon_file.paa",true]] FMP;


//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////
sleep 120;

#define INTERVALL 10
#define TASK _task
#define CONDITION {_a=0;{If ((alive _x)&&((side _x)==dorb_side )) then {INC(_a);};}forEach ((_this select 0) nearEntities (_this select 1));If (_a < 8) then {true}else{false};}
#define CONDITIONARGS [_position,_radius]
#define SUCESSCONDITION {true}
#define ONSUCESS {[-1,{_this spawn FM(disp_info)},["STR_DORB_CLEAR",["STR_DORB_FINISHED"],"data\icon\icon_file.paa",true]] FMP;}
[INTERVALL,TASK,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS] call FM(taskhandler);

LOG("Task clear beendet");