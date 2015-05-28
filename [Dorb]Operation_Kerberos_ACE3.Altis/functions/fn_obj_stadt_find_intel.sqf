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
_gebaeudepos_arr = [_position,_rad] FCALL(get_buildings);

//////////////////////////////////////////////////
////// Ziel erstellen						 /////
//////////////////////////////////////////////////
d_log("Find Intel")

//_rand = floor(random 5) + 6;
_rand=1;

for "_i" from 1 to _rand do{
	_einheit = dorb_intel select floor random count dorb_intel;
	_spawngebaeude = _gebaeudepos_arr select floor random count _gebaeudepos_arr;
	_spawnposition = _spawngebaeude select floor random count _spawngebaeude;
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
[-1,{_this FSPAWN(disp_info)},[localize "STR_DORB_FIND",[_aufgabenname],"data\icon\icon_search.paa",true]] FMP;
//[[localize "STR_DORB_FIND",[_aufgabenname],"data\icon\icon_search.paa",true],"dorb_fnc_disp_info",true] spawn BIS_fnc_MP ;
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
[-1,{_this FSPAWN(disp_info)},[localize "STR_DORB_FIND",[localize "STR_DORB_FINISHED"],"data\icon\icon_search.paa",true]] FMP;
//[[localize "STR_DORB_FIND",[localize "STR_DORB_FINISHED"],"data\icon\icon_search.paa",true],"dorb_fnc_disp_info",true] spawn BIS_fnc_MP ;