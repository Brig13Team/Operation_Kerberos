/*
	Author: Dorbedo

	Description:
	Creates Mission "Destroy Weaponcache".
	

	Parameter(s):
		0 :	ARRAY - Position
		1 :	ARRAY - Ziele
		2 : STRING - Aufgabenname für Taskmaster
		
	Returns:
	BOOL
*/
#include "script_component.hpp"
CHECK(!isServer)

LOG(FORMAT_1("Destroy Device \n this=%1",_this));
PARAMS_3(_ort,_position,_task);

private["_rand","_target","_spawnposition","_target","_einheit","_unit"];
_target=[];
_spawnposition=[];

//////////////////////////////////////////////////
////// Ziel erstellen						 /////
//////////////////////////////////////////////////

//_rand = ((floor(random 5)) + 6);
_rand = 1;
_all_spawnpos = [];
for "_i" from 1 to _rand do{
	_einheit = dorb_device SELRND;
	_spawnposition = [_position,25,200,15,0.15] call FM(pos_flatempty);
	If (_spawnposition isEqualTo []) then {
		_spawnposition = [_position,25,200,15,0.22] call FM(pos_flatempty);
	};
	If (_spawnposition isEqualTo []) then {
		_spawnposition = [_position,200,0] call FM(random_pos);
		_spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];
		if (_spawnposition isEqualTo []) then {
			ERROR(FORMAT_1("Keine Spawnposition | %1",_spawnposition));
		}else{
			_unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
			_target pushBack _unit;
			_all_spawnpos pushBack _spawnposition;
		};
	}else{
		[_spawnposition,3,(random 360)] call FM(spawn_macro);
		_unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
		_target pushBack _unit;
		_all_spawnpos pushBack _spawnposition;
	};
	
};

_centerpos = [_all_spawnpos] call FM(positionsMean);
If (_centerpos isEqualTo []) then {_centerpos = _position;};

//////////////////////////////////////////////////
////// Gegner erstellen 					 /////
//////////////////////////////////////////////////

[_centerpos] call FM(spawn_obj_sonstiges);


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
	private["_a","_mrkr"];
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
#define INTERVALL 10
#define TASK _task
#define CONDITION {_a = {GETVAR(_x,DORB_TARGET_DEAD,false);}count (_this select 0);If (_a == (count (_this select 0))) then {true}else{false};}
#define CONDITIONARGS [_target]
#define SUCESSCONDITION {true}
#define ONSUCESS {[-1,{_this spawn FM(disp_info)},["STR_DORB_DESTROY",["STR_DORB_FINISHED"],"data\icon\icon_destroy.paa",true]] FMP;}
#define ONFAILURE {}
#define SUCESSARG []
#define ONLOOP {If (isnil "DORB_EARTHQUAKE_COUNTER") then {DORB_EARTHQUAKE_COUNTER=8;};DORB_EARTHQUAKE_COUNTER = DORB_EARTHQUAKE_COUNTER - 1;If (DORB_EARTHQUAKE_COUNTER<0) then {[-1, {_rand=(floor(random 4)+1);[_rand]spawn BIS_fnc_earthquake;}] FMP;DORB_EARTHQUAKE_COUNTER = 8+(floor(random 6));};}
#define ONLOOPARGS []
[INTERVALL,TASK,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS,ONFAILURE,SUCESSARG,ONLOOP,ONLOOPARGS] call FM(taskhandler);
