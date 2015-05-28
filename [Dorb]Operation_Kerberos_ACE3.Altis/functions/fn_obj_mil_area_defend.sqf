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

private["_position","_task","_ort","_pow"];

d_log("Task Defend")

_ort=_this select 0;
_position=_this select 1;
_task=_this select 2;
_rad=1200;

_list=[];
aufgabenstatus=true;

//////////////////////////////////////////////////
////// Aufgabe erstellen 					 /////
//////////////////////////////////////////////////

_aufgabenname = format [localize "STR_DORB_DEF_TASK",_ort];
_beschreibung = format [localize "STR_DORB_DEF_TASK_DESC",_ort];
[-1,{_this FSPAWN(disp_info)},[localize "STR_DORB_DEFEND",[_aufgabenname],"data\icon\icon_defend.paa",true]] FMP;
//[[localize "STR_DORB_DEFEND",[_aufgabenname],"data\icon\icon_defend.paa",true],"dorb_fnc_disp_info",true] spawn BIS_fnc_MP ;
[_task,_aufgabenname,_beschreibung,true,[],"created",_position] call SHK_Taskmaster_add;


//////////////////////////////////////////////////
////// Warten, bis Spieler in Bereich		 /////
//////////////////////////////////////////////////

_missionsstatus=true;
//_missionsstatus=false;
while {_missionsstatus} do {
	_a=0;
	sleep 15;
	{If ((_x distance _position) < 1000) then {_a=_a+1;};} forEach playableUnits;
	If (_a > 0) then {_missionsstatus=false};
	CHECK(!aufgabenstatus)
};

If(!aufgabenstatus) exitWith {[_task,"failed"] call SHK_Taskmaster_upd;};

d_log("Defend - Spieler im Bereich")
[-1,{_this FSPAWN(disp_info)},[localize "STR_DORB_DEF",[localize "STR_DORB_DEF_ATT1",localize "STR_DORB_DEF_ATT2"]]] FMP;
//[[localize "STR_DORB_DEF",[localize "STR_DORB_DEF_ATT1",localize "STR_DORB_DEF_ATT2"]],"dorb_fnc_disp_info",true] spawn BIS_fnc_MP ;
sleep 15;
//////////////////////////////////////////////////
////// Vorbereitungszeit					 /////
//////////////////////////////////////////////////

for "_i" from 0 to 11 do {
	_minuten = (13-_i);
	[-1,{_this FSPAWN(disp_message)},[localize "STR_DORB_DEF",format[localize "STR_DORB_DEF_ATT_IN",_minuten]]] FMP;
	//[[localize "STR_DORB_DEF",format[localize "STR_DORB_DEF_ATT_IN",_minuten]],"dorb_fnc_disp_message",true] spawn BIS_fnc_MP ;
	sleep 60;
}; 

//////////////////////////////////////////////////
////// Angriff 			 					 /////
//////////////////////////////////////////////////

DORB_WAVES_REMAINING=3;
aufgabenstatus=true;

[_position] FSPAWN(spawn_attack_waves);

//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////

sleep 300;

_gescheitert=false;
while {aufgabenstatus} do {

	_b=0;
	sleep 25;

	
	{If (_x distance _position < 1500) then {_b=_b+1;};} forEach playableUnits;
	
	d_log(FORMAT_1("Spieler im Berreich = %1",_b))
		
	If (_b < 1) then {_gescheitert=true;aufgabenstatus=false};
	
	If (DORB_WAVES_REMAINING < 1) then {_gescheitert=false;aufgabenstatus=false};
	
};

if (_gescheitert) then {
	[_task,"failed"] call SHK_Taskmaster_upd;
	[-1,{_this FSPAWN(disp_info)},[localize "STR_DORB_DEFEND",[localize "STR_DORB_FAILED"],"data\icon\icon_defend.paa",true]] FMP;
	//[[localize "STR_DORB_DEFEND",[localize "STR_DORB_FAILED"],"data\icon\icon_defend.paa",true],"dorb_fnc_disp_info",true] spawn BIS_fnc_MP ;
}else{
	[_task,"succeeded"] call SHK_Taskmaster_upd;
	[-1,{_this FSPAWN(disp_info)},[localize "STR_DORB_DEFEND",[localize "STR_DORB_FINISHED"],"data\icon\icon_defend.paa",true]] FMP;
	//[[localize "STR_DORB_DEFEND",[localize "STR_DORB_FINISHED"],"data\icon\icon_defend.paa",true],"dorb_fnc_disp_info",true] spawn BIS_fnc_MP ;
};
d_log("Defend beendet");
