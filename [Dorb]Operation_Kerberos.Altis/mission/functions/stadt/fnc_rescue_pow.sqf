/*
	Author: Dorbedo

	Description:
	Creates Mission "Rescue".
	


	Parameter(s):
		0 :	ARRAY - Position
		1 :	ARRAY - Trigger Area [A,B,Winkel,BOOL]
		2 : STRING - Aufgabenname für Taskmaster
		
*/
#include "script_component.hpp"
SCRIPT(rescue_pow);
CHECK(!isServer)
PARAMS_3(_ort,_position,_task);
private["_position_rescue","_pow"];

LOG("Generiere Stadt-POW");

_position_rescue = getMarkerPos "rescue_marker";
_pow=[];

//////////////////////////////////////////////////
////// Gebäudearray erstellen				 /////
//////////////////////////////////////////////////

_rad = 260;
_gebaeudepos_arr = [];
_gebaeudepos_arr = [_position,_rad] call EFUNC(common,get_buildings);

//////////////////////////////////////////////////
////// Geiseln erstellen 					 /////
//////////////////////////////////////////////////
_rand = floor(random 4) + 3;

for "_i" from 1 to _rand do{
	_gruppe = createGroup civilian;
	SETPVAR(_gruppe,GVAR(istarget),true);
	_gruppe allowFleeing 0;
	_einheit = dorb_pow SELRND;
	_spawngebaeude = _gebaeudepos_arr SELRND;
	_spawnposition = _spawngebaeude SELRND;
	_unit = [_spawnposition,_gruppe,_einheit] call EFUNC(spawn,unit);
	SETPVAR(_unit,GVAR(istarget),true);
	_pow pushBack _unit;
};

//////////////////////////////////////////////////
////// Geiseln bearbeiten					 /////
//////////////////////////////////////////////////

{
	removeAllAssignedItems _x;
	removeallweapons _x;
	removeHeadgear _x;
	removeBackpack _x;
	_x disableAI "MOVE";
	_x disableAI "FSM";
	[_x,true] call ace_captives_fnc_setHandcuffed;

	if (dorb_debug) then {
		_mrkr = createMarker [format ["%1-POW:%2",_task,_x],(getPos _x)];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorBlack";
		_mrkr setMarkerType "hd_destroy";
	};
	[_x,QGVAR(rescuepoint),(QUOTE(INC(GVAR(rescue_counter));)+"moveOut (_this select 0);uisleep 0.3;deleteVehicle (_this select 0);")] call BIS_fnc_addScriptedEventHandler;
} forEach _pow;

//////////////////////////////////////////////////
////// Gegner erstellen 					 /////
//////////////////////////////////////////////////

[_position,_gebaeudepos_arr] call EFUNC(spawn,obj_stadt);

//////////////////////////////////////////////////
////// Aufgabe erstellen 					 /////
//////////////////////////////////////////////////

[_task,true,[[LSTRING(RESC_TASK_DESC),count _pow,_ort],LSTRING(RESC_TASK),LSTRING(RESCUE)],_position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;
[LSTRING(RESCUE),[LSTRING(RESC_TASK)],"data\icon\icon_rescue.paa",true] spawn EFUNC(interface,disp_info_global);


//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////

GVAR(rescue_counter) = 0;

["init",_pow] spawn FUNC(examine);

#define INTERVALL 10
#define TASK _task
#define CONDITION {_a={alive _x}count (_this select 0);If((GVAR(rescue_counter)==count(_this select 0))||(_a==0)) then {true}else{false};}
#define CONDITIONARGS [_pow]
#define SUCESSCONDITION {If (GVAR(rescue_counter)>0) then {true}else{false};}
#define ONSUCESS {[LSTRING(RESCUE),[LSTRING(FINISHED)],"data\icon\icon_rescue.paa",true] spawn EFUNC(interface,disp_info_global);['destroy'] spawn FUNC(examine);}
#define ONFAILURE {[LSTRING(RESCUE),[LSTRING(FAILED)],"data\icon\icon_rescue.paa",true] spawn EFUNC(interface,disp_info_global);['destroy'] spawn FUNC(examine);}
#define SUCESSARG []
#define ONLOOP {['check'] spawn FUNC(examine);}
[INTERVALL,TASK,CONDITION,CONDITIONARGS,SUCESSCONDITION,ONSUCESS,ONFAILURE,SUCESSARG,ONLOOP] call FUNC(taskhandler);

