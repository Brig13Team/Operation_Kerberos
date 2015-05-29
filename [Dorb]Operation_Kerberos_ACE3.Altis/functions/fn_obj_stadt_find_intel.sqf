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
#include "makros.hpp"
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
d_log("Find Intel")

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
	[[_x],"dorb_fnc_obj_stadt_found_intel",nil,true,true ] call BIS_fnc_MP;
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

[_position,_gebaeudepos_arr] FCALL(spawn_obj_stadt);

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
[_target,"init"] FSPAWN(examine);
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
	
	[_target,"check"] FSPAWN(examine);
	If (_a == (count _target)) then {aufgabenstatus=false};
};
[_target,"destroy"] FSPAWN(examine);
[_task,"succeeded"] call SHK_Taskmaster_upd;

{deleteVehicle _x}forEach _target;
[-1,{["stadtintel",2] call FM(disp_localization)}] FMP;