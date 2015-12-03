	/*
	Author: Dorbedo

	Description:
	Creates Mission "SCARAB".
	


	Parameter(s):
		0 :	ARRAY - Position
		1 :	ARRAY - Ziele
		2 : STRING - Aufgabenname für Taskmaster
		
	Returns:
	BOOL
*/
#include "script_component.hpp"
SCRIPT(Scarab);

CHECK(!isServer)
LOG(FORMAT_1("SCARAB \n this=%1",_this));
PARAMS_3(_ort,_position,_task);
Private["_target","_einheit","_spawnposition","_unit","_mapSize","_dir","_crew"];
_target=[];
_spawnposition=[];


//////////////////////////////////////////////////
////// Ziel erstellen						 /////
//////////////////////////////////////////////////

_rand = ((floor(random 2)) + 2);
_all_spawnpos = [];
for "_i" from 1 to _rand do{
	_einheit = "rhs_9k79";
	_spawnposition = [_position,200,0] call EFUNC(common,random_pos);
	_spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];				//// to do: isFlatEmpty
	
	if (count _spawnposition < 1) then {
		LOG(FORMAT_1("Keine Spawnposition // %1",_spawnposition));
	}else{
		
		_unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
		sleep 0.5;
		_unit setVectorUp [0,0,1];
		_unit lock 3;
		createVehicleCrew _unit;
		//_unit setDir _dir;
		_unit engineOn false;
		_target pushBack _unit;
	};
	
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
			uisleep 1;
			_unit setVectorUp [0,0,1];
			_unit lock 3;
			SETPVAR(_unit,ACE_vehicleLock_lockpickStrength,-1);
			createVehicleCrew _unit;
			_unit engineOn false;
			_target pushBack _unit;
			_all_spawnpos pushBack _spawnposition;
		};
	}else{
		
		_unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
		uisleep 1;
		_unit setVectorUp [0,0,1];
		_unit lock 3;
		createVehicleCrew _unit;
		_unit engineOn false;
		
		_target pushBack _unit;
		_all_spawnpos pushBack _spawnposition;
	};
	
};
_centerpos = [_all_spawnpos] call EFUNC(common,positionsMean);
If (_centerpos isEqualTo []) then {_centerpos = _position;};

_mapSize = getNumber(configFile >> "CfgWorlds" >> worldName >> "MapSize");
_dir = [(_target select 0),[(_mapSize/2),(_mapSize/2),0]] call BIS_fnc_relativeDirTo;

if ((_dir >=45)	&&(_dir < 225)) then {
	If (_dir < 135) then {
		_dir = [(_target select 0),[_mapSize,(_mapSize/2),0]] call BIS_fnc_relativeDirTo;
	}else{
		_dir = [(_target select 0),[(_mapSize/2),0,0]] call BIS_fnc_relativeDirTo;
	};
}else{
	If (_dir < 315) then {
		_dir = [(_target select 0),[0,(_mapSize/2),0]] call BIS_fnc_relativeDirTo;
	}else{
		_dir = [(_target select 0),[(_mapSize/2),_mapSize,0]] call BIS_fnc_relativeDirTo;
	};
};


{
	_x setDir (_dir + 180);
	_crew = crew _x;
	{
		_x disableAI "TARGET";
		_x disableAI "AUTOTARGET";
		_x disableAI "MOVE";
		_x disableAI "ANIM";
		_x disableAI "FSM";
		_x disableAI "AIMINGERROR";
		_x disableAI "SUPPRESSION";
	}forEach _crew;

} forEach _target;

LOG(FORMAT_2("Scarab created - %1 \n Targetarray = %2",count _target,_target));

//////////////////////////////////////////////////
////// Ziel bearbeiten						 /////
//////////////////////////////////////////////////



if (dorb_debug) then {
	Private["_a","_mrkr"];
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
sleep 30;
private "_temp";
_temp=[];
{
	if (alive _x) then {_temp pushBack _x;};
}forEach _target;
_target=_temp;
{_x addEventHandler ["Killed", {[(getPos (_this select 0))] call FUNC(sonst_Scarab_explode);}]}forEach _target;
private ["_ZeitInMinuten","_deploy"];
_ZeitInMinuten = 80;
GVAR(endzeit) = diag_tickTime + (60*_ZeitInMinuten);
publicVariable QGVAR(endzeit);
_deploy=false;

[_task,true,[[LSTRING(DEST_SCARAB_TASK_DESC),_ort,(count _target)],[LSTRING(DEST_SCARAB_TASK),_ZeitInMinuten],LSTRING(DESTROY)],_position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;
[-1,{[_this select 0,[format [localize (_this select 1),_this select 2]],_this select 3,_this select 4] spawn EFUNC(interface,disp_info);},[LSTRING(DESTROY),LSTRING(DEST_SCARAB_TASK),_ZeitInMinuten,"data\icon\icon_destroy.paa",true]] FMP;

//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////


#define INTERVALL 10
#define TASK _task
#define CONDITION {_a=0;_b=0;_a = {(!(alive gunner _x))} count (_this select 0);_b = {(!(alive _x))} count (_this select 0);If (diag_tickTime>GVAR(endzeit))exitWith {{if (alive _x) then {[_x] spawn FUNC(sonst_Scarab_launch);sleep 3;};}forEach (_this select 0);sleep 30;true};If ((_a == (count (_this select 0)))||(_b>0)) then {true}else{false};}
#define CONDITIONARGS [_target]
#define SUCESSCONDITION {_a=0;_a = {(alive _x)}count (_this select 0);If ((_a == (count (_this select 0)))&&(diag_tickTime<GVAR(endzeit))) then {true}else{false};}
#define ONSUCESS {[LSTRING(DESTROY),[LSTRING(FINISHED)],"data\icon\icon_destroy.paa",true] spawn EFUNC(interface,disp_info_global);}
#define ONFAILURE {[LSTRING(DESTROY),[LSTRING(FAILED)],"data\icon\icon_destroy.paa",true] spawn EFUNC(interface,disp_info_global);}
#define SUCESSARG [_target]
#define ONLOOP {If (GVAR(endzeit) < (diag_tickTime + 300)) then {{If ( (alive _x)	&&	( GETVAR(_x,GVAR(scarab_waiting),true) )) then {	SETVAR(_x,GVAR(scarab_waiting),false);[_x,1] spawn rhs_fnc_ss21_AI_prepare;};}forEach (_this select 0);};}
#define ONLOOPARGS [_target]
[INTERVALL,TASK,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS,ONFAILURE,SUCESSARG,ONLOOP,ONLOOPARGS] call FUNC(taskhandler);
GVAR(endzeit) = 0;
publicVariable QGVAR(endzeit);