/*
	Author: Dorbedo

	Description:
	Creates Mission "SCARAB".
	
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

LOG(FORMAT_1("SCARAB \n this=%1",_this));

_ort=_this select 0;
_position=_this select 1;
_task=_this select 2;
_target=[];
_spawnposition=[];
_changeposition=[];


//////////////////////////////////////////////////
////// Ziel erstellen						 /////
//////////////////////////////////////////////////

//_rand = ((floor(random 2)) + 1);
_rand=4;
for "_i" from 1 to _rand do{
	_einheit = "rhs_9k79";
	_spawnposition = [_position,200,0] call FM(random_pos);
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
};
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




/*
{
	_x setdamage 0;
	SETVAR(_x,DORB_TARGET_DEAD,false);
	_x addEventHandler ["HandleDamage", {_this call dorb_fnc_handledamage_C4;}];	
} forEach _target;
*/
{(getpos _x) spawn FM(spawn_defence);} forEach _target;

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
sleep 30;
_temp=[];
{
	if (alive _x) then {_temp pushBack _x;};
}forEach _target;
_target=_temp;


//_startzeit = serverTime;
_startzeit = time;
_ZeitInMinuten = 62;
DORB_ENDZEIT = _startzeit + (60*_ZeitInMinuten);
publicVariable "DORB_ENDZEIT";
_deploy=false;


_aufgabenname = format [localize "STR_DORB_DEST_SCARAB_TASK",_ZeitInMinuten];
_beschreibung = format [localize "STR_DORB_DEST_SCARAB_TASK_DESC",_ort,(count _target)];
[-1,{["sonstscarab",1,[_ZeitInMinuten]] call FM(disp_localization)}] FMP;
[_task,_aufgabenname,_beschreibung,true,[],"created",_position] call SHK_Taskmaster_add;

//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////
aufgabenstatus=true;
_geschafft=true;


LOG(FORMAT_1("Werfer=%1",_target));
while {aufgabenstatus} do {
	_a=0;
	sleep 15;
	{
		If (!(alive gunner _x)) then 
		{
			INC(_a);
		};
		If (!(alive _x)) exitWith {[getPos _x] spawn FM(obj_sonst_Scarab_explode);sleep 30;_geschafft=false;aufgabenstatus=false;};
	}forEach _target;
	
	LOG(FORMAT_2("Scarab disabled - %1 \n Targetarray = %2",_a,_target));
	
	If (_a == (count _target)) then {aufgabenstatus=false};
	
	LOG(FORMAT_1("Restzeit=%1",DORB_ENDZEIT-time));
	
	if (((DORB_ENDZEIT-time)<300)&&(!_deploy)) then {
		{
			if (alive _x) then {[_x,1] spawn rhs_fnc_ss21_AI_prepare;};
		}forEach _target;
	
	};
	If (time > DORB_ENDZEIT) then {
		{
			if (alive _x) then {[_x] spawn FM(obj_sonst_Scarab_launch);_geschafft=false;sleep 30;aufgabenstatus=false;};
		}forEach _target;
	};
	
};
If (_geschafft) then {
	[_task,"succeeded"] call SHK_Taskmaster_upd;
	[-1,{["sonstscarab",2] call FM(disp_localization)}] FMP;
}else{
	[_task,"failed"] call SHK_Taskmaster_upd;
	[-1,{["sonstscarab",3] call FM(disp_localization)}] FMP;
};