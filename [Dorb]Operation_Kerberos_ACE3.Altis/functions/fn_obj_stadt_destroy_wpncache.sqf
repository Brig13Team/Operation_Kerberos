/*
	Author: Dorbedo

	Description:
	Creates Mission "Destroy Weaponcache".
	
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


private["_position","_task","_ort","_position_rescue","_a"];

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

_rand = ((floor(random 5)) + 8);

for "_i" from 1 to _rand do{
	_einheit = dorb_wpncache_list SELRND;
	_spawngebaeude = _gebaeudepos_arr SELRND;
	_spawnposition = _spawngebaeude SELRND;
	_unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
	_target pushBack _unit;
};
d_log(FORMAT_2("Anzahl Waffenkisten=%1 / Waffenkisten=%2",_rand,_target))

//////////////////////////////////////////////////
////// Ziel bearbeiten						 /////
//////////////////////////////////////////////////

if (dorb_debug) then {
	_a=1;
	{
		INC(_a);
		_mrkr = createMarker [format ["Box %2-%1",_a,_task],getPos _x];
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

_aufgabenname = localize "STR_DORB_DEST_WPN_TASK";
_beschreibung = format [localize "STR_DORB_DEST_WPN_TASK_DESC",_ort];
[-1,{["stadtwpn",1] call FM(disp_localization)}] FMP;

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
			"Bo_Mk82" createVehicle (getpos _x);
			deletevehicle _x;
		};
	}forEach _target;
	
	[_target,"check"] FSPAWN(examine);
	If (_a > ((count _target)-4)) then {aufgabenstatus=false};
};
[_target,"destroy"] FSPAWN(examine);

[_task,"succeeded"] call SHK_Taskmaster_upd;

{deleteVehicle _x}forEach _target;

[-1,{["stadtwpn",2] call FM(disp_localization)}] FMP;