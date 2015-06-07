/*
	Author: Dorbedo

	Description:
	Creates Mission "Kill".
	
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

PARAMS_4(_ort,_position,_task,_gebaeudearr);

private["_position_rescue","_target","_gruppe"];

_target=[];

LOG("Kill Commander");

//////////////////////////////////////////////////
////// Gebäudearray erstellen				 /////
//////////////////////////////////////////////////

_rad = 260;
_gebaeudepos_arr = [];
_gebaeudepos_arr = [_position,_rad] call FM(get_buildings);

//////////////////////////////////////////////////
////// Ziel erstellen						 /////
//////////////////////////////////////////////////

_rand = ((floor(random 2)) + 2);

for "_i" from 1 to _rand do{
	_gruppe = createGroup dorb_side;
	_einheit = dorb_commanderlist SELRND;
	_spawngebaeude = _gebaeudepos_arr SELRND;
	_spawnposition = _spawngebaeude SELRND;
	_unit = [_spawnposition,_gruppe,_einheit] call FM(spawn_unit);
	_target pushBack _unit;
};

//////////////////////////////////////////////////
////// Ziel bearbeiten						 /////
//////////////////////////////////////////////////

{
	_x allowFleeing 0;
	if (isnil (primaryWeapon _x)) then {
		_x addMagazine ["150Rnd_762x51_Box_Tracer",4];
		_x addWeapon "LMG_Zafir_F";
		_x selectWeapon "LMG_Zafir_F";
	};
	_x addEventHandler 	["Killed", 
							{
								[-1,{[_this select 0,[format [localize (_this select 1),_this select 2]],_this select 3,_this select 4] spawn FM(disp_info);},["STR_DORB_KILL","STR_DORB_KILL_KILLED",(name(_this select 0)),"data\icon\icon_target.paa",true]] FMP;
							}
						];	
}forEach _target;

_name = name(_target select 0);
for "_i" from 1 to ((count _target) - 2) do {
	_name = FORMAT_2("%1, %2",_name,name (_target select _i));
};
_name = FORMAT_2("%1 and %2",_name,name(_target select ((count _target)-1)));

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

[_task,true,[["STR_DORB_KILL_TASK_DESC",_name,_ort],"STR_DORB_KILL_TASK","STR_DORB_KILL"],_position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;

[-1,{_this spawn FM(disp_info)},["STR_DORB_KILL",["STR_DORB_KILL_TASK"],"data\icon\icon_target.paa",true]] FMP;
//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////

["init",_target] spawn FM(examine);


#define INTERVALL 30
#define CONDITION {_a ={!(alive _x)}count (_this select 0);If (_a == (count _target)) then {true}else{false};}
#define CONDITIONARGS [_target]
#define SUCESSCONDITION {true}
#define ONSUCESS {[(_this select 0),'SUCCEEDED',false] spawn BIS_fnc_taskSetState;[-1,{_this spawn FM(disp_info)},["STR_DORB_KILL",["STR_DORB_FINISHED"],"data\icon\icon_target.paa",true]] FMP;['destroy',_this select 1] spawn FM(examine);{deleteVehicle _x}forEach (_this select 0);}
#define ONFAILURE {}
#define SUCESSARG [_task,_target]
#define ONLOOP {['check',_this select 0] spawn FM(examine);}
#define ONLOOPARGS [_target]
[INTERVALL,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS,ONFAILURE,SUCESSARG,ONLOOP,ONLOOPARGS] call FM(taskhandler);
