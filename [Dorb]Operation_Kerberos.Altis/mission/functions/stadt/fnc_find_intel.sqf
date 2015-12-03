/*
	Author: Dorbedo

	Description:
	Creates Mission "Find Intel".
	


	Parameter(s):
		0 :	ARRAY - Position
		1 :	ARRAY - Ziele
		2 : STRING - Aufgabenname für Taskmaster
		
	Returns:
	BOOL
*/
#include "script_component.hpp"
SCRIPT(find_intel);
CHECK(!isServer)


private["_position_rescue","_pow"];
params["_ort","_position","_task"];

_target=[];

//////////////////////////////////////////////////
////// Gebäudearray erstellen				 /////
//////////////////////////////////////////////////

_rad = 260;
_gebaeudepos_arr = [];
_gebaeudepos_arr = [_position,_rad] call EFUNC(common,get_buildings);

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
	[-1,{_this call FUNC(stadt_found_intel);},[_x]] FMP;
}forEach _target;
GVAR(interl_obj) = _target;
publicVariable QGVAR(interl_obj);

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

[_position,_gebaeudepos_arr] call EFUNC(spawn,obj_stadt);

//////////////////////////////////////////////////
////// Aufgabe erstellen 					 /////
//////////////////////////////////////////////////

[LSTRING(FIND),[LSTRING(INTEL_TASK)],"data\icon\icon_search.paa",true] spawn EFUNC(interface,disp_info_global);
[_task,true,[[LSTRING(INTEL_TASK_DESC),_ort],LSTRING(INTEL_TASK),LSTRING(FIND)],_position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;

//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////
["init",_target] spawn FUNC(examine);

#define INTERVALL 10
#define TASK _task
#define CONDITION {_a ={!(alive _x)}count (_this select 0);If (_a == (count _target)) then {true}else{false};}
#define CONDITIONARGS [_target]
#define SUCESSCONDITION {true}
#define ONSUCESS {[LSTRING(FIND),[LSTRING(FINISHED)],"data\icon\icon_search.paa",true] spawn EFUNC(interface,disp_info_global);['destroy'] spawn FUNC(examine);{deleteVehicle _x}forEach (_this select 1);GVAR(interl_obj)=[];publicVariable QGVAR(interl_obj);}
#define ONFAILURE {}
#define SUCESSARG [_task,_target]
#define ONLOOP {['check'] spawn FUNC(examine);}
[INTERVALL,TASK,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS,ONFAILURE,SUCESSARG,ONLOOP] call FUNC(taskhandler);
