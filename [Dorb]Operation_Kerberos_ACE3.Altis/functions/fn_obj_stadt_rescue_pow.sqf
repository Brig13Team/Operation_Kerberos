/*
	Author: Dorbedo

	Description:
	Creates Mission "Rescue".
	
	Requirements:
		SHK_Taskmaster

	Parameter(s):
		0 :	ARRAY - Position
		1 :	ARRAY - Trigger Area [A,B,Winkel,BOOL]
		2 : STRING - Aufgabenname für Taskmaster
		
*/
#include "makros.hpp"
CHECK(!isServer)

private["_position","_task","_ort","_position_rescue","_pow"];

[["Generiere Stadt-POW // this=",_this],0] call dorb_fnc_debug_format;

_ort=_this select 0;
_position=_this select 1;
_task=_this select 2;

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
	_einheit = dorb_pow select floor random count dorb_pow;
	_spawngebaeude = _gebaeudepos_arr select floor random count _gebaeudepos_arr;
	_spawnposition = _spawngebaeude select floor random count _spawngebaeude;
	_unit = [_spawnposition,_gruppe,_einheit] call dorb_fnc_spawn_unit;
	SETPVAR(_unit,DORB_ISTARGET,true);
	_pow pushBack _unit;
};


//////////////////////////////////////////////////
////// Gegner erstellen 					 /////
//////////////////////////////////////////////////

[_position,_gebaeudepos_arr] FCALL(spawn_obj_stadt);

//////////////////////////////////////////////////
////// Aufgabe erstellen 					 /////
//////////////////////////////////////////////////

_aufgabenname = localize "STR_DORB_RESC_TASK";
_beschreibung = format [localize "STR_DORB_RESC_TASK_DESC",count _pow,_ort];

[-1,{["stadtpow",1] call FM(disp_localization)}] FMP;
[_task,_aufgabenname,_beschreibung,true,[],"created",_position] call SHK_Taskmaster_add;


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

[_pow,"init"] FSPAWN(examine);
aufgabenstatus=true;
while {aufgabenstatus} do {
	_a=0;
	sleep 5;
	
	{
		If (((_x distance _position_rescue < 20)and(alive _x))or !(alive _x)) then 
		{
			INC(_a);
		};
	}forEach _pow;
	
	[_pow,"check"] FSPAWN(examine);
	If (_a == count _pow) then {aufgabenstatus=false};
};
[_pow,"destroy"] FSPAWN(examine);

_anzahlgerettete={alive _x}count _pow;


If (_anzahlgerettete>0) then {
	[_task,"succeeded"] call SHK_Taskmaster_upd;
	[-1,{["stadtpow",2] call FM(disp_localization)}] FMP;
}else{
	[_task,"failed"] call SHK_Taskmaster_upd;
	[-1,{["stadtpow",3] call FM(disp_localization)}] FMP;
};

{moveOut _x;sleep 0.2; deleteVehicle _x}forEach _pow;

