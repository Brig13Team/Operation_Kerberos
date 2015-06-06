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

[_task,true,[["STR_DORB_DEST_KOM_TASK_DESC",_ort],"STR_DORB_DEST_KOM_TASK","STR_DORB_DESTROY"],_position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;

[-1,{_this spawn FM(disp_info)},["STR_DORB_DESTROY",["STR_DORB_DEST_KOM_TASK"],"data\icon\icon_destroy.paa",true]] FMP;
//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////
#define INTERVALL 30
#define CONDITION {_a = {GETVAR(_x,DORB_TARGET_DEAD,false);}count (_this select 0);If (_a == (count _target)) then {true}else{false};}
#define CONDITIONARGS [_target]
#define SUCESSCONDITION {true}
#define ONSUCESS {[(_this select 0),'SUCCEEDED',false] spawn BIS_fnc_taskSetState;[-1,{_this spawn FM(disp_info)},["STR_DORB_DESTROY",["STR_DORB_FINISHED"],"data\icon\icon_destroy.paa",true]] FMP;}
#define ONFAILURE {}
#define SUCESSARG [_task]
[INTERVALL,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS,ONFAILURE,SUCESSARG] call FM(taskhandler);
