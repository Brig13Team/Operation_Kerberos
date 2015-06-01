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
aufgabenstatus=true;
sleep 120;
while {aufgabenstatus} do {
	_a=0;
	sleep 20;
	_list = (_position) nearEntities _radius;
	{
		If ((alive _x)&&((side _x)==dorb_side )) then 
		{
			INC(_a);
		};
	}forEach _list;
	If (_a < 8) then {aufgabenstatus=false;};
};

[_task,"succeeded"] call SHK_Taskmaster_upd;
[-1,{["milclear",2] call FM(disp_localization)}] FMP;
LOG("Task clear beendet");