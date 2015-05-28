/*
	Author: Dorbedo
	
	Description:
		Selects Mission
	
	Parameter(s):
		0 : STRING	- TASKNAME
	
*/
#include "makros.hpp"

private ["_aufgabe","_rand"];

_aufgabe = [_this,0,format["NOTNUMMER%1",random 1000000],[""]] call BIS_fnc_param;
_aufgabentyp = [_this,1,"leer",[""]] call BIS_fnc_param;


_aufgabentypen =[	"destroy_tower",	"destroy_device",	"capture_prototype",	"Scarab",
					"rescue_pow",		"kill_person",		"find_intel",			"destroy_wpncache",	"konvoi_destroy",	"konvoi_rescue",
					"area_clear",		"area_defend"
				];
_gewichtung = 	[	1,					1,					1,						1,
					1,					1,					0.8,					1,					1,					0.8,
					0.8,				0.8
				];
If (!(_aufgabentyp in _aufgabentypen)) then {
	_aufgabentyp = [_aufgabentypen,_gewichtung] call BIS_fnc_selectRandomWeighted;
};
d_log(FORMAT_1("Aufgabentyp=%1",_aufgabentyp))


[] call FM(create_unitlists);


/// Militär

If (_aufgabentyp isEqualTo "area_clear") exitWith {
		_locarr=(GETMVAR(DORB_MILITAER,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,mil,area_clear));
		d_log("Aufgabe Militär abgeschlossen")
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};
If (_aufgabentyp isEqualTo "area_defend") exitWith {
		_locarr=(GETMVAR(DORB_MILITAER,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,mil,area_defend));
		d_log("Aufgabe Militär abgeschlossen")
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};

/// SONSTIGES

If (_aufgabentyp isEqualTo "destroy_tower") exitWith {
		_locarr=(GETMVAR(DORB_SONSTIGES,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,sonst,destroy_tower));
		d_log("Aufgabe Sonstiges abgeschlossen")
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};
If (_aufgabentyp isEqualTo "destroy_device") exitWith {
		_locarr=(GETMVAR(DORB_SONSTIGES,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,sonst,destroy_device));
		d_log("Aufgabe Sonstiges abgeschlossen")
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};
If (_aufgabentyp isEqualTo "capture_prototype") exitWith {
		_locarr=(GETMVAR(DORB_SONSTIGES,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,sonst,capture_prototype));
		d_log("Aufgabe Sonstiges abgeschlossen")
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};
If (_aufgabentyp isEqualTo "Scarab") exitWith {
		_locarr=(GETMVAR(DORB_SONSTIGES,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,sonst,Scarab));
		d_log("Aufgabe Sonstiges abgeschlossen")
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};

/// STADT
	
If (_aufgabentyp isEqualTo "rescue_pow") exitWith {
		_locarr=(GETMVAR(DORB_STADT,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,stadt,rescue_pow));
		d_log("Aufgabe Stadt abgeschlossen")
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};
If (_aufgabentyp isEqualTo "kill_person") exitWith {
		_locarr=(GETMVAR(DORB_STADT,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,stadt,kill_person));
		d_log("Aufgabe Stadt abgeschlossen")
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};
If (_aufgabentyp isEqualTo "find_intel") exitWith {
		_locarr=(GETMVAR(DORB_STADT,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,stadt,find_intel));
		d_log("Aufgabe Stadt abgeschlossen")
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};
If (_aufgabentyp isEqualTo "destroy_wpncache") exitWith {
		_locarr=(GETMVAR(DORB_STADT,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,stadt,destroy_wpncache));
		d_log("Aufgabe Stadt abgeschlossen")
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};
If (_aufgabentyp isEqualTo "konvoi_destroy") exitWith {
		_locarr=(GETMVAR(DORB_STADT,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,stadt,konvoi_destroy));
		d_log("Aufgabe Stadt abgeschlossen")
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};
If (_aufgabentyp isEqualTo "konvoi_rescue") exitWith {
		_locarr=(GETMVAR(DORB_STADT,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,stadt,konvoi_rescue));
		d_log("Aufgabe Stadt abgeschlossen")
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

//[(_loc select 1),format["%1_rtb",_aufgabe]] call dorb_fnc_obj_rtb;


/*

[] call FM(create_unitlists);

_rand = floor(random 100);
d_log(FORMAT_1("Aufgabenrandom=%1",_rand))

If (_rand < 60) then {
		If (_rand < 40) then {
			d_log("Location = Stadt")
			[_aufgabe] call FM(obj_stadt_create);
		}else{
			d_log("Location = Sonstiges")
			[_aufgabe] call FM(obj_sonst_create);
		};
}else{
	If (_rand < 90) then {
		If (_rand < 75) then {
			d_log("Location = Militaer")
			[_aufgabe] call FM(obj_mil_create);
		}else{
			d_log("Location = Industrie")
			//[_aufgabe] call FM(obj_ind_create);
		};	
	}else{
			d_log("Location = Wasser")
			//[_aufgabe] call FM(obj_tauch_create);
	};
};



//----------------SONSTIGES

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
		case 0: {[(_loc select 0),(_loc select 1),_taskn] call FM(obj_sonst_destroy_tower);};
		case 1: {[(_loc select 0),(_loc select 1),_taskn] call FM(obj_sonst_destroy_device);};
		case 2: {[(_loc select 0),(_loc select 1),_taskn] call FM(obj_sonst_capture_prototype);};
		case 3: {[(_loc select 0),(_loc select 1),_taskn] call FM(obj_sonst_Scarab);};
		case 4: {};
		case 5: {};
	};
	_tasklist pushBack _taskn;
};

d_log("Aufgabe sonstiges abgeschlossen")

[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);

//----------------STADT

_task = _this select 0;

_stadt = GETMVAR(DORB_STADT,[]);
_loc = _stadt call BIS_fnc_selectRandom;

d_log(FORMAT_1("STADT=%1",_loc))

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
	
	d_log(FORMAT_1("Aufgabentypnummer=",_aufgabentyp))
	//			obj_stadt_find_intel,	obj_stadt_destroy_wpncache,	obj_stadt_konvoi_destroy,	obj_stadt_konvoi_rescue,
	switch _aufgabentyp do {
		case 0: {d_log("Stadt - POW")[(_loc select 0),(_loc select 1),_taskn] call dorb_fnc_obj_stadt_rescue_pow;};		// Rescue POW
		case 1: {d_log("Stadt - Commander")[(_loc select 0),(_loc select 1),_taskn] call dorb_fnc_obj_stadt_kill_person;};   	// Kill Commander
		case 2: {d_log("Stadt - intel")[(_loc select 0),(_loc select 1),_taskn] call dorb_fnc_obj_stadt_find_intel;}; 		// Find Intel
		case 3: {d_log("Stadt - Ammobox")[(_loc select 0),(_loc select 1),_taskn] call dorb_fnc_obj_stadt_destroy_wpncache;};	// Destroy Ammobox
		case 4: {d_log("Stadt - Konvoi_Destroy")[(_loc select 0),(_loc select 1),_taskn] call dorb_fnc_obj_stadt_konvoi_destroy;};				// Konvoi stoppen
		case 5: {d_log("Stadt - Konvoi_POW")[(_loc select 0),(_loc select 1),_taskn] call dorb_fnc_obj_stadt_konvoi_rescue;}; 				// Gefangene befreien
		case 6: {};
	};
	//_tasklist pushBack _taskn;
};
d_log("Aufgabe Stadt abgeschlossen")

[(_loc select 1),format["%1_rtb",_aufgabe]] call dorb_fnc_obj_rtb;

//----------------Militär


_task = _this select 0;

_militaer = GETMVAR(DORB_MILITAER,[]);
_loc = _militaer call BIS_fnc_selectRandom;

_pos = _loc select 1;

// Aufgabe erstelllen && Erfuellung abwarten

_aufgabentyp=floor(random 2); 				//später höher setzen

//_aufgabentyp=0;
	
switch _aufgabentyp do {
	case 0: {d_log("Militär - Clear")[(_loc select 0),(_loc select 1),_task] call dorb_fnc_obj_mil_area_clear;};		// Clear Area
	case 1: {d_log("Militär - Defend")[(_loc select 0),(_loc select 1),_task] call dorb_fnc_obj_mil_area_defend;};   	// Defend Area
	case 2: {};	//  		
	case 3: {};
	case 4: {};
	case 5: {};
};
d_log("Aufgabe Militär abgeschlossen")


[(_loc select 1),format["%1_rtb",_aufgabe]] call dorb_fnc_obj_rtb;

*/