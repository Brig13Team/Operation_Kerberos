/*
	Author: Dorbedo

	Description:
	Creates Mission "Clear Area".
	
	Requirements:
		SHK_Taskmaster

	Parameter(s):
		0 :	ARRAY - Position
		1 :	ARRAY - Ziele
		2 : STRING - Aufgabenname für Taskmaster
		
	Returns:
	BOOL
*/

#include "script_component.hpp"
CHECK(!isServer)

private["_position_rescue","_pow","_aufgabenname","_beschreibung"];
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

_aufgabenname = format [localize "STR_DORB_CLEAR_TASK",_ort];
_beschreibung = format [localize "STR_DORB_CLEAR_TASK_DESC",_ort];

[-1,{["milclear",1,_this] call FM(disp_localization)},[_ort]] FMP;

[_task,_aufgabenname,_beschreibung,true,[],"created",_position] call SHK_Taskmaster_add;

//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////
sleep 120;

#define INTERVALL 30
#define CONDITION {_a=0;{If ((alive _x)&&((side _x)==dorb_side )) then {INC(_a);};}forEach ((_this select 0) nearEntities (_this select 1));If (_a < 8) then {true}else{false};}
#define CONDITIONARGS [_position,_radius]
#define SUCESSCONDITION {true}
#define ONSUCESS {[(_this select 0),'succeeded'] call SHK_Taskmaster_upd;[-1,{['milclear',2] call FM(disp_localization);}] FMP;}
#define ONFAILURE {}
#define SUCESSARG [_task]
[INTERVALL,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS,ONFAILURE,SUCESSARG] call FM(taskhandler);

LOG("Task clear beendet");