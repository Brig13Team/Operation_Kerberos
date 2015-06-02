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

private["_position_rescue","_a"];

LOG(FORMAT_1("Destroy Device \n this=%1",_this));
PARAMS_3(_ort,_position,_task);

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
	_spawnposition = [_position,200,0] call FM(random_pos);
	_spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];
	
	if (count _spawnposition < 1) then {
		ERROR(FORMAT_1("Keine Spawnposition | %1",_spawnposition));
	}else{
		_unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
		_target pushBack _unit;
	};
	
};

//////////////////////////////////////////////////
////// Gegner erstellen 					 /////
//////////////////////////////////////////////////

[_position] call FM(spawn_obj_sonstiges);


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
#define INTERVALL 30
#define CONDITION {_a ={GETVAR(_x,DORB_TARGET_DEAD,false);}count (_this select 0);If (_a == (count _target)) then {true}else{false};}
#define CONDITIONARGS []
#define SUCESSCONDITION {true}
#define ONSUCESS {[_this select 0,'succeeded'] call SHK_Taskmaster_upd;[-1,{['sonstdevice',2] call FM(disp_localization);}] FMP;}
#define ONFAILURE {}
#define SUCESSARG [_task]
[INTERVALL,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS,ONFAILURE,SUCESSARG] call FM(taskhandler);
