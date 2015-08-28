/*
	Author: Dorbedo

	Description:
	Creates Mission "Clear Area".
	


	Parameter(s):
		0 :	ARRAY - Position
		1 :	ARRAY - Ziele
		2 : STRING - Aufgabenname für Taskmaster
		
	Returns:
	BOOL
*/
#include "script_component.hpp"
SCRIPT(obj_mil_defend);
CHECK(!isServer)
LOG("Task Defend");
PARAMS_3(_ort,_position,_task);
private["_rad","_list","_minuten"];
_rad=1200;
_list=[];

//////////////////////////////////////////////////
////// Aufgabe erstellen 					 /////
//////////////////////////////////////////////////

[_task,true,[[LSTRING(DEF_TASK_DESC),_ort],[LSTRING(DEF_TASK),_ort],LSTRING(DEFEND)],_position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;
[-1,{[_this select 0,[format [localize (_this select 1),_this select 2]],_this select 3,_this select 4] spawn EFUNC(interface,disp_info);},[LSTRING(DEFEND),LSTRING(DEF_TASK),_ort,"data\icon\icon_defend.paa",true]] FMP;


//////////////////////////////////////////////////
////// Warten, bis Spieler in Bereich		 /////
//////////////////////////////////////////////////

#define INTERVALL 15
#define TASK ""
#define CONDITION {_a=0;_players=(switchableUnits + playableUnits);_a = {((_x distance2D (_this select 0))<1000)}count _players;If (_a > 0) then {true}else{false};}
#define CONDITIONARGS [_position]
[INTERVALL,TASK,CONDITION,CONDITIONARGS] call FUNC(taskhandler);

If(taskcancel) exitWith {[_task,'CANCELED',false] spawn BIS_fnc_taskSetState;};

LOG("Defend - Spieler im Bereich");

[LSTRING(DEF),[LSTRING(DEF_ATT1),LSTRING(DEF_ATT2)],"data\icon\icon_defend.paa",true] spawn EFUNC(interface,disp_info_global);

sleep 15;
//////////////////////////////////////////////////
////// Vorbereitungszeit					 /////
//////////////////////////////////////////////////

for "_i" from 0 to 11 do {
	_minuten = (13-_i);
	[-1,{[_this select 0,[format [localize (_this select 1),_this select 2]],_this select 3,_this select 4] spawn EFUNC(interface,disp_info);},[LSTRING(DEF),LSTRING(DEF_ATT_IN),_minuten,"data\icon\icon_defend.paa",true]] FMP;
	sleep 60;
}; 

//////////////////////////////////////////////////
////// Angriff 			 					 /////
//////////////////////////////////////////////////

GVAR(waves_remaining)=3;

[_position,_task] spawn EFUNC(spawn,attack_waves);

//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////

sleep 300;

#define INTERVALL 10
#define TASK _task
#define CONDITION {_a=0;_a = {((alive _x)&&((_x distance2D (_this select 0))<1800))}count (switchableUnits + playableUnits);If ((_a<1)||(GVAR(waves_remaining)<1)) then {true}else{false};}
#define CONDITIONARGS [_position]
#define SUCESSCONDITION {_a=0;_a = {((alive _x)&&((_x distance2D (_this select 0))<1500))}count (switchableUnits + playableUnits);If (_a>0) then {true}else{false};}
#define ONSUCESS {[LSTRING(DEFEND),[LSTRING(FINISHED)],"data\icon\icon_defend.paa",true] spawn EFUNC(interface,disp_info_global);}
#define ONFAILURE {[LSTRING(DEFEND),[LSTRING(FAILED)],"data\icon\icon_defend.paa",true] spawn EFUNC(interface,disp_info_global);}
#define SUCESSARG [_position]
[INTERVALL,TASK,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS,ONFAILURE,SUCESSARG] call FUNC(taskhandler);

LOG("Defend beendet");