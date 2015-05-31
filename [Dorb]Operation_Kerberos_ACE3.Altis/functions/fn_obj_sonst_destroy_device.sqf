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

d_log(FORMAT_1("Destroy Device // %1",_this))

_ort=_this select 0;
_position=_this select 1;
_task=_this select 2;

_target=[];
_spawnposition=[];
_changeposition=[];

//////////////////////////////////////////////////
////// Ziel erstellen						 /////
//////////////////////////////////////////////////

//_rand = ((floor(random 5)) + 6);
_rand = 1;

for "_i" from 1 to _rand do{
	_einheit = dorb_device SELRND;
	_spawnposition = [_position,200,0] FCALL(random_pos);
	_spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];
	
	if (count _spawnposition < 1) then {
		d_log(FORMAT_1("Keine Spawnposition | %1",_spawnposition))
	}else{
		_unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
		_target pushBack _unit;
	};
	
};

//////////////////////////////////////////////////
////// Gegner erstellen 					 /////
//////////////////////////////////////////////////

[_position] FCALL(spawn_obj_sonstiges);


//////////////////////////////////////////////////
////// Ziel bearbeiten						 /////
//////////////////////////////////////////////////

{
	_x setdamage 0;
	SETVAR(_x,DORB_TARGET_DEAD,false);
	_x addEventHandler ["HandleDamage", {_this call dorb_fnc_handledamage_C4;}];	
} forEach _target;


{(getpos _x) FSPAWN(spawn_defence)} forEach _target;


if (dorb_debug) then {
	_a=1;
	{
		INC(_a);
		_mrkr = createMarker [format ["Box %2-%1",_a,_task],getPos _x];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorBlue";
		_mrkr setMarkerType "hd_destroy";
		
	}forEach _target;
};

sleep 5;

//////////////////////////////////////////////////
////// Aufgabe erstellen 					 /////
//////////////////////////////////////////////////

_aufgabenname = localize "STR_DORB_DEST_DEV_TASK";
_beschreibung = localize "STR_DORB_DEST_DEV_TASK_DESC";
[-1,{["sonstdevice",1] call FM(disp_localization)}] FMP;

[_task,_aufgabenname,_beschreibung,true,[],"created",_position] call SHK_Taskmaster_add;

//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////

aufgabenstatus=true;
_b=0;
while {aufgabenstatus} do {
	_a=0;
	sleep 30;
	
	{
		If (GETVAR(_x,DORB_TARGET_DEAD,false)) then 
		{
			INC(_a);
		};
	}forEach _target;
	
	If (_a == (count _target)) then {aufgabenstatus=false;};
	
	INC(_b);
	If (_b>10) then {
		[-1, {_rand=(floor(random 4)+1);[_rand]spawn BIS_fnc_earthquake;}] FMP;
		_b=0;
	};
};

[_task,"succeeded"] call SHK_Taskmaster_upd;

{deleteVehicle _x}forEach _target;

[-1,{["sonstdevice",2] call FM(disp_localization)}] FMP;