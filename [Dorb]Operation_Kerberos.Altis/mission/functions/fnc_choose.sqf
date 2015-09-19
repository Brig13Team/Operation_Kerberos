/*
	Author: Dorbedo
	
	Description:
		Selects Mission
	
	Parameter(s):
		0 : STRING	- TASKNAME
		0 : STRING	- TASK TYP (Optional)
	
*/
#include "script_component.hpp"
SCRIPT(choose);
private ["_aufgabe","_rand","_aufgabentyp","_gewichtung","_i"];

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
					0.8,				0
				];
};
If (!(_aufgabentyp in _aufgabentypen)) then {
	for "_i" from 1 to 100 do {
		_aufgabentyp = [_aufgabentypen,_gewichtung] call BIS_fnc_selectRandomWeighted;
		if (_aufgabentyp != (GETMVAR(GVAR(last_mission_type),""))) exitWith {};
	};
};
LOG(FORMAT_1("Aufgabentyp=%1",_aufgabentyp));

SETMVAR(GVAR(last_mission_type),_aufgabentyp);

[] call EFUNC(spawn,create_unitlists);
//_aufgabentyp="rescue_pow";
/// Militär
Private["_loc","_locarr"];
If (_aufgabentyp isEqualTo "area_clear") exitWith {
		_locarr=(GETMVAR(GVAR(militaer),[]));
		_loc = _locarr SELRND;
		//[(_loc select 0),(_loc select 1),_aufgabe] spawn FUNC(sideby_chooseMission);
		[(_loc select 0),(_loc select 1),_aufgabe] call FUNC(DOUBLES(mil,area_clear));
		LOG("Aufgabe Militär abgeschlossen");
		[(_loc select 1),_aufgabe] call FUNC(rtb);
	};
If (_aufgabentyp isEqualTo "area_defend") exitWith {
		_locarr=(GETMVAR(GVAR(militaer),[]));
		_loc = _locarr SELRND;
		//[(_loc select 0),(_loc select 1),_aufgabe] spawn FUNC(sideby_chooseMission);
		[(_loc select 0),(_loc select 1),_aufgabe] call FUNC(DOUBLES(mil,area_defend));
		LOG("Aufgabe Militär abgeschlossen");
		[(_loc select 1),_aufgabe] call FUNC(rtb);
	};

/// SONSTIGES

If (_aufgabentyp isEqualTo "destroy_tower") exitWith {
		_locarr=(GETMVAR(GVAR(sonstiges),[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] spawn FUNC(sideby_chooseMission);
		[(_loc select 0),(_loc select 1),_aufgabe] call FUNC(DOUBLES(sonst,destroy_tower));
		LOG("Aufgabe Sonstiges abgeschlossen");
		[(_loc select 1),_aufgabe] call FUNC(rtb);
	};
If (_aufgabentyp isEqualTo "destroy_device") exitWith {
		_locarr=(GETMVAR(GVAR(sonstiges),[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] spawn FUNC(sideby_chooseMission);
		[(_loc select 0),(_loc select 1),_aufgabe] call FUNC(DOUBLES(sonst,destroy_device));
		LOG("Aufgabe Sonstiges abgeschlossen");
		[(_loc select 1),_aufgabe] call FUNC(rtb);
	};
If (_aufgabentyp isEqualTo "capture_prototype") exitWith {
		_locarr=(GETMVAR(GVAR(sonstiges),[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] spawn FUNC(sideby_chooseMission);
		[(_loc select 0),(_loc select 1),_aufgabe] call FUNC(DOUBLES(sonst,capture_prototype));
		LOG("Aufgabe Sonstiges abgeschlossen");
		[(_loc select 1),_aufgabe] call FUNC(rtb);
	};
If (_aufgabentyp isEqualTo "Scarab") exitWith {
		_locarr=(GETMVAR(GVAR(sonstiges),[]));
		_loc = _locarr SELRND;
		LOG_2(_locarr,_loc);
		LOG(QUOTE(FUNC(DOUBLES(sonst,scarab))));
		
		[(_loc select 0),(_loc select 1),_aufgabe] call FUNC(DOUBLES(sonst,scarab));
		LOG("Aufgabe Sonstiges abgeschlossen");
		[(_loc select 1),_aufgabe] call FUNC(rtb);
	};

/// STADT
	
If (_aufgabentyp isEqualTo "rescue_pow") exitWith {
		_locarr=(GETMVAR(GVAR(stadt),[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] spawn FUNC(sideby_chooseMission);
		[(_loc select 0),(_loc select 1),_aufgabe] call FUNC(DOUBLES(stadt,rescue_pow));
		LOG("Aufgabe Stadt abgeschlossen");
		[(_loc select 1),_aufgabe] call FUNC(rtb);
	};
If (_aufgabentyp isEqualTo "kill_person") exitWith {
		_locarr=(GETMVAR(GVAR(stadt),[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] spawn FUNC(sideby_chooseMission);
		[(_loc select 0),(_loc select 1),_aufgabe] call FUNC(DOUBLES(stadt,kill_person));
		LOG("Aufgabe Stadt abgeschlossen");
		[(_loc select 1),_aufgabe] call FUNC(rtb);
	};
If (_aufgabentyp isEqualTo "find_intel") exitWith {
		_locarr=(GETMVAR(GVAR(stadt),[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] spawn FUNC(sideby_chooseMission);
		[(_loc select 0),(_loc select 1),_aufgabe] call FUNC(DOUBLES(stadt,find_intel));
		LOG("Aufgabe Stadt abgeschlossen");
		[(_loc select 1),_aufgabe] call FUNC(rtb);
	};
If (_aufgabentyp isEqualTo "destroy_wpncache") exitWith {
		_locarr=(GETMVAR(GVAR(stadt),[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] spawn FUNC(sideby_chooseMission);
		[(_loc select 0),(_loc select 1),_aufgabe] call FUNC(DOUBLES(stadt,destroy_wpncache));
		LOG("Aufgabe Stadt abgeschlossen");
		[(_loc select 1),_aufgabe] call FUNC(rtb);
	};
If (_aufgabentyp isEqualTo "konvoi_destroy") exitWith {
		_locarr=(GETMVAR(GVAR(stadt),[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FUNC(DOUBLES(stadt,konvoi_destroy));
		LOG("Aufgabe Stadt abgeschlossen");
		[(_loc select 1),_aufgabe] call FUNC(rtb);
	};
If (_aufgabentyp isEqualTo "konvoi_rescue") exitWith {
		_locarr=(GETMVAR(GVAR(stadt),[]));
		_loc = _locarr SELRND;
		[(_loc select 0),(_loc select 1),_aufgabe] call FUNC(DOUBLES(stadt,konvoi_rescue));
		LOG("Aufgabe Stadt abgeschlossen");
		[(_loc select 1),_aufgabe] call FUNC(rtb);
	};
