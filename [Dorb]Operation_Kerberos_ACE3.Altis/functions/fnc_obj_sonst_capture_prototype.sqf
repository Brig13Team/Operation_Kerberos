/*
	Author: Dorbedo

	Description:
	Creates Mission "Capture Prototyp".
	


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

private["_position_rescue","_target","_spawnposition","_unit","_einheit","_rand"];

_position_rescue = getMarkerPos "rescue_marker";
_target=[];
_spawnposition=[];

///////////////////////////////////////////////
////// Ziel erstellen					 /////
///////////////////////////////////////////////

//_rand = ((floor(random 2)) + 1);
_rand=1;
_all_spawnpos = [];
for "_i" from 1 to _rand do{
	_einheit = dorb_prototyp SELRND;
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
		[_spawnposition,["missionConfigFile","defence_positions","missions","device"],(random 360)] call FM(spawn_macro_exec3d);
		_unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
		_target pushBack _unit;
		_all_spawnpos pushBack _spawnposition;
	};
};

_centerpos = [_all_spawnpos] call FM(positionsMean);
If (_centerpos isEqualTo []) then {_centerpos = _position;};

///////////////////////////////////////////////
////// Ziel bearbeiten					 /////
///////////////////////////////////////////////

//{(getpos _x) spawn FM(spawn_defence);} forEach _target;


if (dorb_debug) then {
	private "_a";
	_a=1;
	{
		INC(_a);
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

[_centerpos] call FM(spawn_obj_sonstiges);

///////////////////////////////////////////////
////// Aufgabe erstellen 				 /////
///////////////////////////////////////////////

DORB_RESCUE_COUNTER = 0;
{[_x,"DORB_RESCUEPOINT","DORB_RESCUE_COUNTER=DORB_RESCUE_COUNTER+1;{moveout _x}forEach(crew(_this select 0));uisleep 0.5;deleteVehicle(_this select 0);"] call BIS_fnc_addScriptedEventHandler;}forEach _target;

[_task,true,[["STR_DORB_PROTO_TASK_DESC",_ort],"STR_DORB_PROTO_TASK","STR_DORB_CAPTURE"],_position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;
["STR_DORB_CAPTURE",["STR_DORB_PROTO_TASK"],"data\icon\icon_capture.paa",true] spawn FM(disp_info_global);
///////////////////////////////////////////////
////// Überprüfung + Ende 				 /////
///////////////////////////////////////////////
#define INTERVALL 10
#define TASK _task
#define CONDITION {_a={alive _x}forEach (_this select 0);If((DORB_RESCUE_COUNTER==count(_this select 0))||(_a==0)) then {true}else{false};}
#define CONDITIONARGS [_target]
#define SUCESSCONDITION {If (DORB_RESCUE_COUNTER>0) then {true}else{false};}
#define ONSUCESS {["STR_DORB_CAPTURE",["STR_DORB_FINISHED"],"data\icon\icon_capture.paa",true] spawn FM(disp_info_global);}
#define ONFAILURE {["STR_DORB_CAPTURE",["STR_DORB_FAILED"],"data\icon\icon_capture.paa",true] spawn FM(disp_info_global);}
#define SUCESSARG []
[INTERVALL,TASK,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS,ONFAILURE,SUCESSARG] call FM(taskhandler);
