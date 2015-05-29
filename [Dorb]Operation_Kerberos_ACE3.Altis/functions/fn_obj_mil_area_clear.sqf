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

#include "makros.hpp"
CHECK(!isServer)

private["_position","_task","_ort","_position_rescue","_pow"];
d_log("Task_Create Clear Military")

_ort=_this select 0;
_position=_this select 1;
_task=_this select 2;

_radius = 1000;
_list=[];
_difficulty = FCALL(difficulty);



//////////////////////////////////////////////////
////// Ziel erstellen						 /////
//////////////////////////////////////////////////

[_position] call FM(spawn_obj_mil);


//////////////////////////////////////////////////
////// Aufgabe erstellen 					 /////
//////////////////////////////////////////////////

_aufgabenname = format [localize "STR_DORB_CLEAR_TASK",_ort];
_beschreibung = format [localize "STR_DORB_CLEAR_TASK_DESC",_ort];

[-1,{["milclear",1,[_ort]] call FM(disp_localization)}] FMP;

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
d_log("Task clear beendet")