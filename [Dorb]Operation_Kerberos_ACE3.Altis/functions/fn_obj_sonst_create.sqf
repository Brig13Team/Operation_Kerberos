/*
	Author: Dorbedo
	
	Description:
		Selects Task "Sonstiges"
		
	Parameter(s):
		0 : STRING	- Taskname (Unikat)

	
	Return
	BOOL
*/
#include "makros.hpp"



_task = _this select 0;
_tasklist = [];

_sonst = GETMVAR(DORB_SONSTIGES,[]);
_loc = _sonst call BIS_fnc_selectRandom;

d_log("Erstelle Aufgabe Sonstiges")

for "_i" from 1 to (Anzahl_Aufgaben) do {
	_aufgabentyp=floor(random 4); 				//später höher setzen
	//_aufgabentyp=3;
	_taskn=FORMAT_2("%1_%2",_task,_i);
	
	d_log(FORMAT_1("Aufgabentyp=%1",_aufgabentyp))
	
	switch _aufgabentyp do {
		case 0: {[(_loc select 0),(_loc select 1),_taskn] FCALL(obj_sonst_destroy_tower);};
		case 1: {[(_loc select 0),(_loc select 1),_taskn] FCALL(obj_sonst_destroy_device);};
		case 2: {[(_loc select 0),(_loc select 1),_taskn] FCALL(obj_sonst_capture_prototype);};
		case 3: {[(_loc select 0),(_loc select 1),_taskn] FCALL(obj_sonst_Scarab);};
		case 4: {};
		case 5: {};
	};
	_tasklist pushBack _taskn;
};

d_log("Aufgabe sonstiges abgeschlossen")

[(_loc select 1),format["%1_rtb",_aufgabe]] FCALL(obj_rtb);