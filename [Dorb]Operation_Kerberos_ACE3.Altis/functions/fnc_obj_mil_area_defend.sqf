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

[_task,true,[["STR_DORB_DEF_TASK_DESC",_ort],["STR_DORB_DEF_TASK",_ort],"STR_DORB_DEFEND"],_position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;
[-1,{[_this select 0,[format [localize (_this select 1),_this select 2]],_this select 3,_this select 4] spawn FM(disp_info);},["STR_DORB_DEFEND","STR_DORB_DEF_TASK",_ort,"data\icon\icon_defend.paa",true]] FMP;


//////////////////////////////////////////////////
////// Warten, bis Spieler in Bereich		 /////
//////////////////////////////////////////////////

#define INTERVALL 15
#define TASK ""
#define CONDITION {_a=0;_players=(switchableUnits + playableUnits);_a = {((_x distance (_this select 0))<1000)}count _players;If (_a > 0) then {true}else{false};}
#define CONDITIONARGS [_position]
[INTERVALL,TASK,CONDITION,CONDITIONARGS] call FM(taskhandler);

If(taskcancel) exitWith {[_task,'CANCELED',false] spawn BIS_fnc_taskSetState;};

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

[_position,_task] spawn FM(spawn_attack_waves);

//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////

sleep 300;

#define INTERVALL 10
#define TASK _task
#define CONDITION {_a=0;_a = {((alive _x)&&((_x distance (_this select 0))<1500))}count (switchableUnits + playableUnits);If ((_a<1)||(DORB_WAVES_REMAINING<1)) then {true}else{false};}
#define CONDITIONARGS [_position]
#define SUCESSCONDITION {_a=0;_a = {((alive _x)&&((_x distance (_this select 0))<1500))}count (switchableUnits + playableUnits);If (_a>0) then {true}else{false};}
#define ONSUCESS {[-1,{_this spawn FM(disp_info)},["STR_DORB_DEFEND",["STR_DORB_FINISHED"],"data\icon\icon_defend.paa",true]] FMP;}
#define ONFAILURE {[-1,{_this spawn FM(disp_info)},["STR_DORB_DEFEND",["STR_DORB_FAILED"],"data\icon\icon_defend.paa",true]] FMP;}
#define SUCESSARG [_position]
[INTERVALL,TASK,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS,ONFAILURE,SUCESSARG] call FM(taskhandler);

LOG("Defend beendet");