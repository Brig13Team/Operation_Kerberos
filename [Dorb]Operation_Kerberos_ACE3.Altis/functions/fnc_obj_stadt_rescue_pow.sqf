/*
	Author: Dorbedo

	Description:
	Creates Mission "Rescue".
	


	Parameter(s):
		0 :	ARRAY - Position
		1 :	ARRAY - Trigger Area [A,B,Winkel,BOOL]
		2 : STRING - Aufgabenname für Taskmaster
		
*/
#include "script_component.hpp"
CHECK(!isServer)
PARAMS_3(_ort,_position,_task);
private["_position_rescue","_pow"];

LOG("Generiere Stadt-POW");

_position_rescue = getMarkerPos "rescue_marker";
_pow=[];

//////////////////////////////////////////////////
////// Gebäudearray erstellen				 /////
//////////////////////////////////////////////////

_rad = 260;
_gebaeudepos_arr = [];
_gebaeudepos_arr = [_position,_rad] call FM(get_buildings);

//////////////////////////////////////////////////
////// Geiseln erstellen 					 /////
//////////////////////////////////////////////////
_rand = floor(random 4) + 3;

for "_i" from 1 to _rand do{
	_gruppe = createGroup civilian;
	_einheit = dorb_pow SELRND;
	_spawngebaeude = _gebaeudepos_arr SELRND;
	_spawnposition = _spawngebaeude SELRND;
	_unit = [_spawnposition,_gruppe,_einheit] call FM(spawn_unit);
	SETPVAR(_unit,DORB_ISTARGET,true);
	_pow pushBack _unit;
};


//////////////////////////////////////////////////
////// Gegner erstellen 					 /////
//////////////////////////////////////////////////

[_position,_gebaeudepos_arr] call FM(spawn_obj_stadt);

//////////////////////////////////////////////////
////// Aufgabe erstellen 					 /////
//////////////////////////////////////////////////



[_task,true,[["STR_DORB_RESC_TASK_DESC",count _pow,_ort],"STR_DORB_RESC_TASK","STR_DORB_RESCUE"],_position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;

[-1,{_this spawn FM(disp_info)},["STR_DORB_RESCUE",["STR_DORB_RESC_TASK"],"data\icon\icon_rescue.paa",true]] FMP;

//////////////////////////////////////////////////
////// Geiseln bearbeiten					 /////
//////////////////////////////////////////////////

{
	_x setCaptive true;
	removeAllAssignedItems _x;
	removeallweapons _x;
	removeHeadgear _x;
	removeBackpack _x;
	_x setunitpos "UP";
	_x setBehaviour "Careless";
	dostop _x;
	_x playmove "amovpercmstpsnonwnondnon_amovpercmstpssurwnondnon";
	_x disableAI "MOVE";

	if (dorb_debug) then {
	_mrkr = createMarker [format ["%1-POW:%2",_aufgabenname,_x],(getPos _x)];
	_mrkr setMarkerShape "ICON";
	_mrkr setMarkerColor "ColorBlack";
	_mrkr setMarkerType "hd_destroy";
	};
	
	
}forEach _pow;



//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////

["init",_pow] spawn FM(examine);

#define INTERVALL 10
#define TASK _task
#define CONDITION {_a=0;_a ={(!(alive _x))||((_x distance (_this select 1))<15)}count (_this select 0);If (_a == (count (_this select 0))) then {true}else{false};}
#define CONDITIONARGS [_pow,_position_rescue]
#define SUCESSCONDITION {_a=0;_a={alive _x}count (_this select 0);If (_a >0) then {true}else{false};}
#define ONSUCESS {[-1,{_this spawn FM(disp_info)},["STR_DORB_RESCUE",["STR_DORB_FINISHED"],"data\icon\icon_rescue.paa",true]] FMP;['destroy'] spawn FM(examine);{moveOut _x;sleep 0.2; deleteVehicle _x}forEach (_this select 0);}
#define ONFAILURE {[-1,{_this spawn FM(disp_info)},["STR_DORB_RESCUE",["STR_DORB_FAILED"],"data\icon\icon_rescue.paa",true]] FMP;['destroy'] spawn FM(examine);{moveOut _x;sleep 0.2; deleteVehicle _x}forEach (_this select 0);}
#define SUCESSARG [_pow]
#define ONLOOP {['check'] spawn FM(examine);}
[INTERVALL,TASK,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS,ONFAILURE,SUCESSARG,ONLOOP] call FM(taskhandler);

