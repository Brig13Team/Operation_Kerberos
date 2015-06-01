/*
	Author: Dorbedo

	Description:
	Creates Mission "Capture Prototyp".
	
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

LOG(FORMAT_1("Get Prototyp \n this=%1",_this));

PARAMS_3(_ort,_position,_task);

private["_position_rescue","_a","_spawnposition","_changeposition"];

_position_rescue = getMarkerPos "rescue_marker";
_target=[];
_spawnposition=[];
_changeposition=[];

///////////////////////////////////////////////
////// Ziel erstellen					 /////
///////////////////////////////////////////////

//_rand = ((floor(random 2)) + 1);
_rand=1;

for "_i" from 1 to _rand do{
	_einheit = dorb_prototyp select floor random count dorb_prototyp;
	LOG_2(_einheit,_position);
	
	_spawnposition = [_position,200,0] call FM(random_pos);
	_spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];				//// to do: isFlatEmpty
	if (count _spawnposition < 1) then {
		ERROR(FORMAT_1("Keine Spawnposition | %1",_spawnposition));
	}else{
		_unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
		_unit setVariable ["DORB_ISTARGET",true,false];
		_target pushBack _unit;
	};
};

///////////////////////////////////////////////
////// Ziel bearbeiten					 /////
///////////////////////////////////////////////

{(getpos _x) spawn FM(spawn_defence)} forEach _target;


if (dorb_debug) then {
	_a=1;
	{
		_a=_a+1;
		_mrkr = createMarker [format ["Box %2-%1",_a,_task],getPos _x];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorBlack";
		_mrkr setMarkerType "hd_destroy";
		
	}forEach _target;
};

sleep 2;

///////////////////////////////////////////////
////// Gegner erstellen 				 /////
///////////////////////////////////////////////

[_position] call FM(spawn_obj_sonstiges);

///////////////////////////////////////////////
////// Aufgabe erstellen 				 /////
///////////////////////////////////////////////

_aufgabenname = localize "STR_DORB_PROTO_TASK";
_beschreibung = format [localize "STR_DORB_PROTO_TASK_DESC",_ort];
[-1,{["sonstproto",1] call FM(disp_localization)}] FMP;

[_task,_aufgabenname,_beschreibung,true,[],"created",_position] call SHK_Taskmaster_add;

///////////////////////////////////////////////
////// Überprüfung + Ende 				 /////
///////////////////////////////////////////////

[
	10,
	{
		_a=0;
		{
			If (((_x distance (_this select 1) < 20)and(alive _x))or !(alive _x)) then 
			{
				INC(_a);
			};
		}forEach (_this select 0);
		If (_a == count (_this select 0)) then {true}else{false};
	},
	[_target,_position_rescue],
	{true},
	{
		[_task,"succeeded"] call SHK_Taskmaster_upd;
		[-1,{["sonstproto",2] call FM(disp_localization)}] FMP;
		{{moveout _x}forEach (crew _x);sleep 0.2;deleteVehicle _x}forEach (_this select 1);
	},
	{
		[_task,"failed"] call SHK_Taskmaster_upd;
		[-1,{["sonstproto",3] call FM(disp_localization)}] FMP;
		{{moveout _x}forEach (crew _x);sleep 0.2;deleteVehicle _x}forEach (_this select 1);
	},
	[_task,_target]
] call FM(taskhandler);

/*

aufgabenstatus=true;
while {aufgabenstatus} do {
	_a=0;
	sleep 5;
	{
		If (((_x distance _position_rescue < 20)and(alive _x))or !(alive _x)) then 
		{
			INC(_a);
		};
	}forEach _target;

	If (_a == count _target) then {aufgabenstatus=false};
};

_anzahlgerettete={alive _x}count _target;

If (_anzahlgerettete>0) then {
	[_task,"succeeded"] call SHK_Taskmaster_upd;
	[-1,{["sonstproto",2] call FM(disp_localization)}] FMP;
}else{
	[_task,"failed"] call SHK_Taskmaster_upd;
	[-1,{["sonstproto",3] call FM(disp_localization)}] FMP;
};

{deleteVehicle _x}forEach _target;
*/