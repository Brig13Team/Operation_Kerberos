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

[_task,true,["STR_DORB_DEST_DEV_TASK_DESC","STR_DORB_DEST_DEV_TASK","STR_DORB_DESTROY"],_position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;
[-1,{_this spawn FM(disp_info)},["STR_DORB_DESTROY",["STR_DORB_DEST_DEV_TASK"],"data\icon\icon_destroy.paa",true]] FMP;


//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////
#define INTERVALL 30
#define CONDITION {_a = {GETVAR(_x,DORB_TARGET_DEAD,false);}count (_this select 0);If (_a == (count (_this select 0))) then {true}else{false};}
#define CONDITIONARGS [_target]
#define SUCESSCONDITION {true}
#define ONSUCESS {[(_this select 0),'SUCCEEDED',false] spawn BIS_fnc_taskSetState;[-1,{_this spawn FM(disp_info)},["STR_DORB_DESTROY",["STR_DORB_FINISHED"],"data\icon\icon_destroy.paa",true]] FMP;}
#define ONFAILURE {}
#define SUCESSARG [_task]
#define ONLOOP {If (isnil "DORB_EARTHQUAKE_COUNTER") then {DORB_EARTHQUAKE_COUNTER=5;};DORB_EARTHQUAKE_COUNTER = DORB_EARTHQUAKE_COUNTER - 1;If (DORB_EARTHQUAKE_COUNTER<0) then {[-1, {_rand=(floor(random 4)+1);[_rand]spawn BIS_fnc_earthquake;}] FMP;DORB_EARTHQUAKE_COUNTER = 5+(floor(random 4));};}
#define ONLOOPARGS []
[INTERVALL,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS,ONFAILURE,SUCESSARG,ONLOOP,ONLOOPARGS] call FM(taskhandler);
