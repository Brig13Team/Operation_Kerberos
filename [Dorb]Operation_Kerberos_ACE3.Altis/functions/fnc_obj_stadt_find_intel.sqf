/*
	Author: Dorbedo

	Description:
	Creates Mission "Find Intel".
	
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


private["_position","_task","_ort","_position_rescue","_pow"];

_ort=_this select 0;
_position=_this select 1;
_task=_this select 2;

_target=[];

//////////////////////////////////////////////////
////// Gebäudearray erstellen				 /////
//////////////////////////////////////////////////

_rad = 260;
_gebaeudepos_arr = [];
_gebaeudepos_arr = [_position,_rad] call FM(get_buildings);

//////////////////////////////////////////////////
////// Ziel erstellen						 /////
//////////////////////////////////////////////////
LOG("Find Intel");

//_rand = floor(random 5) + 6;
_rand=1;

for "_i" from 1 to _rand do{
	_einheit = dorb_intel SELRND;
	_spawngebaeude = _gebaeudepos_arr SELRND;
	_spawnposition = _spawngebaeude SELRND;
	_unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
	_target pushBack _unit;
};

//////////////////////////////////////////////////
////// Ziel bearbeiten						 /////
//////////////////////////////////////////////////

{
	[-1,{_this call dorb_fnc_obj_stadt_found_intel},[_x]] FMP;
}forEach _target;


if (dorb_debug) then {
	{
		_mrkr = createMarker [name _x,getPos _x];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorBlack";
		_mrkr setMarkerType "hd_destroy";
		
	}forEach _target;
};

//////////////////////////////////////////////////
////// Gegner erstellen 					 /////
//////////////////////////////////////////////////

[_position,_gebaeudepos_arr] call FM(spawn_obj_stadt);

//////////////////////////////////////////////////
////// Aufgabe erstellen 					 /////
//////////////////////////////////////////////////

[-1,{_this spawn FM(disp_info)},["STR_DORB_FIND",["STR_DORB_INTEL_TASK"],"data\icon\icon_search.paa",true]] FMP;
[_task,true,[["STR_DORB_INTEL_TASK_DESC",_ort],"STR_DORB_INTEL_TASK","STR_DORB_FIND"],_position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;

//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////
["init",_target] spawn FM(examine);

#define INTERVALL 30
#define TASK _task
#define CONDITION {_a ={!(alive _x)}count (_this select 0);If (_a == (count _target)) then {true}else{false};}
#define CONDITIONARGS [_target]
#define SUCESSCONDITION {true}
#define ONSUCESS {[-1,{_this spawn FM(disp_info)},["STR_DORB_FIND",["STR_DORB_FINISHED"],"data\icon\icon_search.paa",true]] FMP;['destroy'] spawn FM(examine);{deleteVehicle _x}forEach (_this select 0);}
#define ONFAILURE {}
#define SUCESSARG [_task,_target]
#define ONLOOP {['check'] spawn FM(examine);}
[INTERVALL,TASK,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS,ONFAILURE,SUCESSARG,ONLOOP] call FM(taskhandler);
