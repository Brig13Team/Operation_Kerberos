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
#include "script_component.hpp"
CHECK(!isServer)

private["_position","_task","_ort","_pow"];

LOG("Task Defend");

_ort=_this select 0;
_position=_this select 1;
_task=_this select 2;
_rad=1200;

_list=[];
aufgabenstatus=true;

//////////////////////////////////////////////////
////// Aufgabe erstellen 					 /////
//////////////////////////////////////////////////

[_task,true,[["STR_DORB_DEF_TASK_DESC",_ort],["STR_DORB_DEF_TASK",_ort],"STR_DORB_DEFEND"],_position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;
[-1,{[_this select 0,[format [localize (_this select 1),_this select 2]],_this select 3,_this select 4] spawn FM(disp_info);},["STR_DORB_DEFEND","STR_DORB_DEF_TASK",_ort,"data\icon\icon_defend.paa",true]] FMP;


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

LOG("Defend - Spieler im Bereich");

[-1,{_this spawn FM(disp_info)},["STR_DORB_DEF",["STR_DORB_DEF_ATT1","STR_DORB_DEF_ATT2"],"data\icon\icon_defend.paa",true]] FMP;

sleep 15;
//////////////////////////////////////////////////
////// Vorbereitungszeit					 /////
//////////////////////////////////////////////////

for "_i" from 0 to 11 do {
	_minuten = (13-_i);
	[-1,{[_this select 0,[format [localize (_this select 1),_this select 2]],_this select 3,_this select 4] spawn FM(disp_info);},["STR_DORB_DEF","STR_DORB_DEF_ATT_IN",_minuten,"data\icon\icon_defend.paa",true]] FMP;
	sleep 60;
}; 

//////////////////////////////////////////////////
////// Angriff 			 					 /////
//////////////////////////////////////////////////

DORB_WAVES_REMAINING=3;
aufgabenstatus=true;

[_position] spawn FM(spawn_attack_waves);

//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////

sleep 300;

_gescheitert=false;
while {aufgabenstatus} do {

	_b=0;
	sleep 25;

	
	{If (_x distance _position < 1500) then {_b=_b+1;};} forEach playableUnits;
	
	LOG(FORMAT_1("Spieler im Berreich = %1",_b));
		
	If (_b < 1) then {_gescheitert=true;aufgabenstatus=false};
	
	If (DORB_WAVES_REMAINING < 1) then {_gescheitert=false;aufgabenstatus=false};
	
};

if (_gescheitert) then {
	[_task,'FAILED',false] spawn BIS_fnc_taskSetState;
	[-1,{_this spawn FM(disp_info)},[ "STR_DORB_DEFEND",["STR_DORB_FAILED"],"data\icon\icon_defend.paa",true]] FMP;
}else{
	[_task,'SUCCEEDED',false] spawn BIS_fnc_taskSetState;
	[-1,{_this spawn FM(disp_info)},["STR_DORB_DEFEND",["STR_DORB_FINISHED"],"data\icon\icon_defend.paa",true]] FMP;
};
LOG("Defend beendet");
