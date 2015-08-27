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

_task = _this select 0;

_militaer = GETMVAR(DORB_MILITAER,[]);
_loc = _militaer call BIS_fnc_selectRandom;

_pos = _loc select 1;

// Aufgabe erstelllen && Erfuellung abwarten

_aufgabentyp=floor(random 2); 				//später höher setzen

//_aufgabentyp=0;
	
switch _aufgabentyp do {
	case 0: {LOG("Militär - Clear");[(_loc select 0),(_loc select 1),_task] call FM(obj_mil_area_clear);};		// Clear Area
	case 1: {LOG("Militär - Defend");[(_loc select 0),(_loc select 1),_task] call FM(obj_mil_area_defend);};   	// Defend Area
	case 2: {};	//  		
	case 3: {};
	case 4: {};
	case 5: {};
};
LOG("Aufgabe Militär abgeschlossen");


[(_loc select 1),format["%1_rtb",_aufgabe]] call FM(obj_rtb);