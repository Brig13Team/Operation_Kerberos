/*
	Author: Dorbedo
	
	Description:
		Selects Mission
	
	Parameter(s):
		0 : STRING	- TASKNAME
	
*/
#include "script_component.hpp"

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
If (worldName == "pja305") then {
_gewichtung = 	[	1,					1,					1,						1,
					1,					1,					0.8,					1,					0,					0,
					0.8,				0.8
				];
};
If (!(_aufgabentyp in _aufgabentypen)) then {
	_aufgabentyp = [_aufgabentypen,_gewichtung] call BIS_fnc_selectRandomWeighted;
};
LOG(FORMAT_1("Aufgabentyp=%1",_aufgabentyp));


[] call FM(create_unitlists);


/// Militär

If (_aufgabentyp isEqualTo "area_clear") exitWith {
		_locarr=(GETMVAR(DORB_MILITAER,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,mil,area_clear));
		LOG("Aufgabe Militär abgeschlossen");
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};
If (_aufgabentyp isEqualTo "area_defend") exitWith {
		_locarr=(GETMVAR(DORB_MILITAER,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,mil,area_defend));
		LOG("Aufgabe Militär abgeschlossen");
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};

/// SONSTIGES

If (_aufgabentyp isEqualTo "destroy_tower") exitWith {
		_locarr=(GETMVAR(DORB_SONSTIGES,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,sonst,destroy_tower));
		LOG("Aufgabe Sonstiges abgeschlossen");
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};
If (_aufgabentyp isEqualTo "destroy_device") exitWith {
		_locarr=(GETMVAR(DORB_SONSTIGES,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,sonst,destroy_device));
		LOG("Aufgabe Sonstiges abgeschlossen");
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};
If (_aufgabentyp isEqualTo "capture_prototype") exitWith {
		_locarr=(GETMVAR(DORB_SONSTIGES,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,sonst,capture_prototype));
		LOG("Aufgabe Sonstiges abgeschlossen");
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};
If (_aufgabentyp isEqualTo "Scarab") exitWith {
		_locarr=(GETMVAR(DORB_SONSTIGES,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,sonst,Scarab));
		LOG("Aufgabe Sonstiges abgeschlossen");
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};

/// STADT
	
If (_aufgabentyp isEqualTo "rescue_pow") exitWith {
		_locarr=(GETMVAR(DORB_STADT,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,stadt,rescue_pow));
		LOG("Aufgabe Stadt abgeschlossen");
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};
If (_aufgabentyp isEqualTo "kill_person") exitWith {
		_locarr=(GETMVAR(DORB_STADT,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,stadt,kill_person));
		LOG("Aufgabe Stadt abgeschlossen");
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};
If (_aufgabentyp isEqualTo "find_intel") exitWith {
		_locarr=(GETMVAR(DORB_STADT,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,stadt,find_intel));
		LOG("Aufgabe Stadt abgeschlossen");
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};
If (_aufgabentyp isEqualTo "destroy_wpncache") exitWith {
		_locarr=(GETMVAR(DORB_STADT,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,stadt,destroy_wpncache));
		LOG("Aufgabe Stadt abgeschlossen");
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};
If (_aufgabentyp isEqualTo "konvoi_destroy") exitWith {
		_locarr=(GETMVAR(DORB_STADT,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,stadt,konvoi_destroy));
		LOG("Aufgabe Stadt abgeschlossen");
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};
If (_aufgabentyp isEqualTo "konvoi_rescue") exitWith {
		_locarr=(GETMVAR(DORB_STADT,[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FM(TRIPLES(obj,stadt,konvoi_rescue));
		LOG("Aufgabe Stadt abgeschlossen");
		[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);
	};