/*
	Author: Dorbedo
	
	Description:
	
	Requirements:
	
	Parameter(s):
		0 : ARRAY	- Example
		1 : ARRAY	- Example
		2 : STRIN	- Example
	
	Return
	BOOL
*/
#include "script_component.hpp"

CHECK(!isServer)


private ["_aufgabennummer","_aktuelle_aufgabe","_return"];

dorb_debug=false; //Marker für Missionen
dorb_debug_log=true;
dorb_debug_loc=false; //Marker für Orte
Anzahl_Aufgaben=1;

_aufgabennummer=0;

_return = [] call FM(get_cfglocations);

SETMVAR(DORB_STADT,(_return select 0));
SETMVAR(DORB_INDUSTRIE,(_return select 1));
SETMVAR(DORB_MILITAER,(_return select 2));
SETMVAR(DORB_WASSER,(_return select 3));
SETMVAR(DORB_SONSTIGES,(_return select 4));

[] spawn {
	while {true} do {
	sleep 1200;
	[] spawn FM(cleanup_small);
	false
	};

};

sleep 20;

for "_u" from 0 to 120 do {
	
	sleep 5;
	INC(_aufgabennummer);
	_aktuelle_aufgabe = FORMAT_1("task_%1",_aufgabennummer);
	d_log(FORMAT_2("Aufgabe=%1 Aufgabename=%2",_aufgabennummer,_aktuelle_aufgabe))
	[_aktuelle_aufgabe] FCALL(obj_choose);
	//[_aktuelle_aufgabe] FCALL(choose_obj);	
};
endMission "End1";