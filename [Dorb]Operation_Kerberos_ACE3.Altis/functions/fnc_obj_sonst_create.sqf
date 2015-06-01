/*
	Author: Dorbedo
	
	Description:
		Selects Task "Sonstiges"
		
	Parameter(s):
		0 : STRING	- Taskname (Unikat)

	
	Return
	BOOL
*/
#include "script_component.hpp"



_task = _this select 0;
_tasklist = [];

_sonst = GETMVAR(DORB_SONSTIGES,[]);
_loc = _sonst call BIS_fnc_selectRandom;

LOG("Erstelle Aufgabe Sonstiges");

for "_i" from 1 to (Anzahl_Aufgaben) do {
	_aufgabentyp=floor(random 4); 				//später höher setzen
	//_aufgabentyp=3;
	_taskn=FORMAT_2("%1_%2",_task,_i);
	
	LOG_1(_aufgabentyp);
	
	switch _aufgabentyp do {
		case 0: {[(_loc select 0),(_loc select 1),_taskn] call FM(obj_sonst_destroy_tower);};
		case 1: {[(_loc select 0),(_loc select 1),_taskn] call FM(obj_sonst_destroy_device);};
		case 2: {[(_loc select 0),(_loc select 1),_taskn] call FM(obj_sonst_capture_prototype);};
		case 3: {[(_loc select 0),(_loc select 1),_taskn] call FM(obj_sonst_Scarab);};
		case 4: {};
		case 5: {};
	};
	_tasklist pushBack _taskn;
};

LOG("Aufgabe sonstiges abgeschlossen");

[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);