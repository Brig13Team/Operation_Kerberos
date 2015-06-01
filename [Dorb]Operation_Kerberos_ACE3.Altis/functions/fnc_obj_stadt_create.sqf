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
PARAMS_1(_task);

_stadt = GETMVAR(DORB_STADT,[]);
_loc = _stadt call BIS_fnc_selectRandom;

LOG(FORMAT_1("STADT=%1",_loc));

//_tasklist = []; //Vorbereitung für meherer Aufgaben in einer Location

//////////////////////////////////////////////////
////// Loop fuer meherere Aufgabentypen		 /////
//////////////////////////////////////////////////

for "_i" from 1 to (Anzahl_Aufgaben) do {
	
	//////////////////////////////////////////////////
	////// Aufgabe auswählen 					 /////
	//////////////////////////////////////////////////
	
	_aufgabentyp=floor(random 6); 					
	_taskn=FORMAT_2("%1_%2",_task,_i);
	
	//_aufgabentyp=4;
	//_aufgabentyp=(floor(random 2))+4;
	
	//////////////////////////////////////////////////
	////// Aufgaben Spawnen + Erfüllung abwarten /////			TODO: Erfüllung bei mehreren Aufgabentypen
	//////////////////////////////////////////////////
	
	LOG(FORMAT_1("Aufgabentypnummer=",_aufgabentyp));
	
	switch _aufgabentyp do {
		case 0: {LOG("Stadt - POW");[(_loc select 0),(_loc select 1),_taskn] call FM(DOUBLES(obj_stadt,rescue_pow));};		// Rescue POW
		case 1: {LOG("Stadt - Commander");[(_loc select 0),(_loc select 1),_taskn] call FM(DOUBLES(obj_stadt,kill_person));};   	// Kill Commander
		case 2: {LOG("Stadt - intel");[(_loc select 0),(_loc select 1),_taskn] call FM(DOUBLES(obj_stadt,find_intel));}; 		// Find Intel
		case 3: {LOG("Stadt - Ammobox");[(_loc select 0),(_loc select 1),_taskn] call FM(DOUBLES(obj_stadt,destroy_wpncache));};	// Destroy Ammobox
		case 4: {LOG("Stadt - Konvoi_Destroy");[(_loc select 0),(_loc select 1),_taskn] call FM(DOUBLES(obj_stadt,konvoi_destroy));};				// Konvoi stoppen
		case 5: {LOG("Stadt - Konvoi_POW");[(_loc select 0),(_loc select 1),_taskn] call FM(DOUBLES(obj_stadt,konvoi_rescue));}; 				// Gefangene befreien
		case 6: {};
	};
	//_tasklist pushBack _taskn;
};
LOG("Aufgabe Stadt abgeschlossen");

[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);