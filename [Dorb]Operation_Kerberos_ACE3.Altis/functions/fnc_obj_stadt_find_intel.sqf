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
	[-1,{_this call FM(obj_stadt_found_intel)},[_x]] FMP;
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

_aufgabenname = localize "STR_DORB_INTEL_TASK";
_beschreibung = format [localize "STR_DORB_INTEL_TASK_DESC",_ort];
[-1,{["stadtintel",1] call FM(disp_localization)}] FMP;
[_task,_aufgabenname,_beschreibung,true,[],"created",_position] call SHK_Taskmaster_add;


//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////
[_target,"init"] spawn FM(examine);

#define INTERVALL 30
#define CONDITION {_a ={!(alive _x)}count (_this select 0);If (_a == (count _target)) then {true}else{false};}
#define CONDITIONARGS [_target]
#define SUCESSCONDITION {true}
#define ONSUCESS {[_this select 0,'succeeded'] call SHK_Taskmaster_upd;[-1,{['stadtintel',2] call FM(disp_localization);}] spawn CBA_fnc_globalExecute;[_this select 1,'destroy'] spawn FM(examine);{deleteVehicle _x}forEach (_this select 1);}
#define ONFAILURE {}
#define SUCESSARG [_task,_target]
#define ONLOOP {[_this select 0,'check'] spawn FM(examine);}
#define ONLOOPARGS [_target]
[INTERVALL,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS,ONFAILURE,SUCESSARG,ONLOOP,ONLOOPARGS] call FM(taskhandler);
