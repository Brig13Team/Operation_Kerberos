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

//PARAMS_4(_ort,_position,_task,_gebaeudearr);

private["_position","_task","_ort","_position_rescue","_target","_gruppe"];

_ort=_this select 0;
_position=_this select 1;
_task=_this select 2;
_gebaeudearr = _this select 3;
_target=[];

d_log("Kill Commander")

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
	_x addEventHandler ["Killed", {[-1,{_this spawn FM(disp_message)},[localize "STR_DORB_KILL",format[localize "STR_DORB_KILL_KILLED",(name(_this select 0))]]] FMP;}];	
}forEach _target;

_name = name(_target select 0);
for "_i" from 1 to ((count _target) - 2) do {
	_name = FORMAT_2("%1, %2",_name,name (_target select _i));
};
_name = FORMAT_2("%1 und %2",_name,name(_target select ((count _target)-1)));

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

_aufgabenname = localize "STR_DORB_KILL_TASK";
_beschreibung = format [localize "STR_DORB_KILL_TASK_DESC",_name,_ort];
[-1,{["stadtcommander",1] call FM(disp_localization)}] FMP;
[_task,_aufgabenname,_beschreibung,true,[],"created",_position] call SHK_Taskmaster_add;

//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////

[_target,"init"] spawn FM(examine);
aufgabenstatus=true;
while {aufgabenstatus} do {
	_a=0;
	sleep 5;
	
	{
		If (!(alive _x)) then 
		{
			INC(_a);
		};
	}forEach _target;
	
	[_target,"check"] spawn FM(examine);
	If (_a == count _target) then {aufgabenstatus=false};
};

[_target,"destroy"] spawn FM(examine);

[_task,"succeeded"] call SHK_Taskmaster_upd;

{deleteVehicle _x}forEach _target;
[-1,{["stadtcommander",2] call FM(disp_localization)}] FMP;