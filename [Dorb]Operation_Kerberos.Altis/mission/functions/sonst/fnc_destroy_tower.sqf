/*
	Author: Dorbedo

	Description:
	Creates Mission "Destroy Tower".
	


	Parameter(s):
		0 :	ARRAY - Position
		1 :	ARRAY - Ziele
		2 : STRING - Aufgabenname für Taskmaster
		
	Returns:
		None
*/
#include "script_component.hpp"
SCRIPT(sonst_destroy_tower);
CHECK(!isServer)

LOG(FORMAT_1("Destroy Tower \n this=%1",_this));
PARAMS_3(_ort,_position,_task);
Private ["_target","_spawnposition","_einheit","_unit"];
_target=[];
_spawnposition=[];

//////////////////////////////////////////////////
////// Ziel erstellen						 /////
//////////////////////////////////////////////////

_rand = ((floor(random 2)) + 1);
_all_spawnpos = [];
for "_i" from 1 to _rand do{
	_einheit = dorb_tower SELRND;
	
	_spawnposition = [_position,25,200,15,0.15] call EFUNC(common,pos_flatempty);
	If (_spawnposition isEqualTo []) then {
		_spawnposition = [_position,25,200,15,0.22] call EFUNC(common,pos_flatempty);
	};
	If (_spawnposition isEqualTo []) then {
		_spawnposition = [_position,200,0] call EFUNC(common,random_pos);
		_spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];
		if (_spawnposition isEqualTo []) then {
			ERROR(FORMAT_1("Keine Spawnposition | %1",_spawnposition));
		}else{
			_unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
			_unit setVectorUp [0,0,1];
			_target pushBack _unit;
			_all_spawnpos pushBack _spawnposition;
		};
	}else{
		
		_unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
		_unit setVectorUp [0,0,1];
		_target pushBack _unit;
		_all_spawnpos pushBack _spawnposition;
	};
	
};


_centerpos = [_all_spawnpos] call EFUNC(common,positionsMean);
If (_centerpos isEqualTo []) then {_centerpos = _position;};


//////////////////////////////////////////////////
////// Ziel bearbeiten						 /////
//////////////////////////////////////////////////

{
	_x setdamage 0;
	SETVAR(_x,GVAR(target_dead),false);
	_x addEventHandler ["HandleDamage", {_this call EFUNC(common,handledamage_C4);}];	
} forEach _target;

//{(getpos _x) spawn FM(spawn_defence)} forEach _target;

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

sleep 2;

//////////////////////////////////////////////////
////// Gegner erstellen 					 /////
//////////////////////////////////////////////////

[_centerpos] call EFUNC(spawn,obj_sonstiges);

//////////////////////////////////////////////////
////// Aufgabe erstellen 					 /////
//////////////////////////////////////////////////

[_task,true,[["STR_DORB_DEST_KOM_TASK_DESC",_ort],"STR_DORB_DEST_KOM_TASK","STR_DORB_DESTROY"],_position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;

["STR_DORB_DESTROY",["STR_DORB_DEST_KOM_TASK"],"data\icon\icon_destroy.paa",true] spawn EFUNC(interface,disp_info_global);
//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////
#define INTERVALL 10
#define TASK _task
#define CONDITION {_a = {GETVAR(_x,GVAR(target_dead),false);}count (_this select 0);If (_a == (count _target)) then {true}else{false};}
#define CONDITIONARGS [_target]
#define SUCESSCONDITION {true}
#define ONSUCESS {["STR_DORB_DESTROY",["STR_DORB_FINISHED"],"data\icon\icon_destroy.paa",true] spawn EFUNC(interface,disp_info_global);}
[INTERVALL,TASK,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS] call FUNC(taskhandler);
