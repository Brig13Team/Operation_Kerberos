/*
	Author: Dorbedo

	Description:
	Creates Mission "Destroy Tower".
	
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

LOG(FORMAT_1("Destroy Tower \n this=%1",_this));
PARAMS_3(_ort,_position,_task);
_target=[];
_spawnposition=[];
_changeposition=[];


//////////////////////////////////////////////////
////// Ziel erstellen						 /////
//////////////////////////////////////////////////

_rand = ((floor(random 2)) + 1);

for "_i" from 1 to _rand do{
	_einheit = dorb_tower SELRND;
	_spawnposition = [_position,200,0] call FM(random_pos);
	_spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];				//// to do: isFlatEmpty
	
	if (count _spawnposition < 1) then {
		ERROR(FORMAT_1("Keine Spawnposition | %1",_spawnposition));
	}else{
		_unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
		_unit setVectorUp [0,0,1];
		_target pushBack _unit;
	};
};

LOG(FORMAT_2("Tower created - %1 \n Targetarray = %2",count _target,_target));

//////////////////////////////////////////////////
////// Ziel bearbeiten						 /////
//////////////////////////////////////////////////

{
	_x setdamage 0;
	SETVAR(_x,DORB_TARGET_DEAD,false);
	_x addEventHandler ["HandleDamage", {_this call dorb_fnc_handledamage_C4;}];	
} forEach _target;

{(getpos _x) spawn FM(spawn_defence)} forEach _target;

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

sleep 2;

//////////////////////////////////////////////////
////// Gegner erstellen 					 /////
//////////////////////////////////////////////////

[_position] call FM(spawn_obj_sonstiges);

//////////////////////////////////////////////////
////// Aufgabe erstellen 					 /////
//////////////////////////////////////////////////

_aufgabenname = localize "STR_DORB_DEST_KOM_TASK";
_beschreibung = format [localize "STR_DORB_DEST_KOM_TASK_DESC",_ort];
[-1,{["sonsttower",1] call FM(disp_localization)}] FMP;
[_task,_aufgabenname,_beschreibung,true,[],"created",_position] call SHK_Taskmaster_add;

//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////

aufgabenstatus=true;
while {aufgabenstatus} do {
	_a=0;
	sleep 15;
	
	{
		If (GETVAR(_x,DORB_TARGET_DEAD,false)) then 
		{
			INC(_a);
		};
	}forEach _target;
	
	LOG(FORMAT_2("Tower dead - %1 \n Targetarray = %2",_a,_target));
	
	If (_a == (count _target)) then {aufgabenstatus=false};
};

[_task,"succeeded"] call SHK_Taskmaster_upd;

{deleteVehicle _x}forEach _target;
[-1,{["sonsttower",2] call FM(disp_localization)}] FMP;