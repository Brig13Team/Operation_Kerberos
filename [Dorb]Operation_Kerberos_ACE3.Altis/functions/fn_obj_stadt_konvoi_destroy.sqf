/*
	Author: Dorbedo

	Description:
	Creates Mission "Rescue".
	
	Requirements:
		SHK_Taskmaster

	Parameter(s):
		0 :	ARRAY - Position
		1 :	ARRAY - Trigger Area [A,B,Winkel,BOOL]
		2 : STRING - Aufgabenname für Taskmaster
		3 : STRING - Name des Missionsortes
		4 : ARRAY - Namen der Geiseln

	Returns:
	Trigger - Serverside with Rescue
*/
#include "makros.hpp"
CHECK(!isServer)


private["_position","_task","_ort","_position_rescue","_pow","_einheit"];

_ort=_this select 0;
_position=_this select 1;
_task=_this select 2;

_stadt = GETMVAR(DORB_STADT,[]);

_startort=[];
_vehicles=[];
_spawn_pos=[];

d_log("Konvoi_Mission - Destroy")

 _b = true;
 for [{_i = 0},{_i < 100 && _b},{_i = _i + 1}] do {
	_startort = _stadt call BIS_fnc_selectRandom;
	if ((((_startort select 1)distance _position)>6000)&&(((_startort select 1)distance _position)<11000)) then {
		_b = false;
	};
 };

//////////////////////////////////////////////////
////// Konvoi erstellen 					 /////
////////////////////////////////////////////////// 


_difficulty = [] FCALL(difficulty);

for "_j" from 0 to _difficulty do {
	for "_i" from 0 to 2 do {
		
		_gruppe = createGroup dorb_side;
		_gruppe addWaypoint [_position,100];
		[_gruppe,0] setWaypointBehaviour "SAFE";
		[_gruppe,0] setWaypointCombatMode "RED";
		[_gruppe,0] setWaypointSpeed "NORMAL";
		[_gruppe,0] setWaypointFormation "COLUMN";
		_gruppe setFormation "COLUMN";
		
		
		_spawn_rad = ((random 200) + 50);
		_spawn_pos = [(_startort select 1), _spawn_rad,0] FCALL(random_pos);
		_road=[_spawn_pos,500,[]] call BIS_fnc_nearestRoad;
		_roadConnectedTo = roadsConnectedTo _road;
		_connectedRoad = _roadConnectedTo select 0;
		_direction = [_road, _connectedRoad] call BIS_fnc_DirTo;
		
		_rand = (floor(random 9));
		if (_rand>3) then {
			if (_rand<5) then {
				_einheit = dorb_veh_aa SELRND;
			}else{
				_einheit = dorb_veh_unarmored SELRND;
			};
		}else{
			_einheit = dorb_veh_armored SELRND;
		};
		
		d_log(FORMAT_2("Konvoi %1:%2 ",_i,_einheit))
				
		_spawnpos = (getPos _road) findEmptyPosition [1,20,_einheit];
		_return = [_spawnpos,_direction,_einheit,_gruppe] call BIS_fnc_spawnVehicle;
		_vehicles = _vehicles + [(_return select 0)];
		
		[(_return select 0),_gruppe] FCALL(spawn_crew);
		
		sleep 0.4;
		[_gruppe] FCALL(moveToHC);
	};
};

d_log(FORMAT_1("Spawnpos=%1",_spawn_pos))

_start_mrkr = createMarker [format["start-%1",(_startort select 1)],(_startort select 1)];
_start_mrkr setMarkerShape "ICON";
_start_mrkr setMarkerColor "ColorBlack";
_start_mrkr setMarkerType "hd_start";


//////////////////////////////////////////////////
////// Aufgabe erstellen 					 /////
//////////////////////////////////////////////////

_aufgabenname = localize "STR_DORB_KILL_CONV_TASK";
_beschreibung = format [localize "STR_DORB_KILL_CONV_TASK_DESC",(_startort select 0),_ort];
[-1,{["stadtconvkill",1] call FM(disp_localization)}] FMP;
[_task,_aufgabenname,_beschreibung,true,[],"created",_position] call SHK_Taskmaster_add;

//////////////////////////////////////////////////
////// Überprüfung + Ende 					 /////
//////////////////////////////////////////////////
_geschafft=true;
aufgabenstatus=true;
while {aufgabenstatus} do {
	_a=0;
	sleep 5;
	
	{
		If ((_x distance _position < 200)and(alive _x)) then {aufgabenstatus=false;_geschafft=false;};
		
		If (!(canMove _x)) then 
		{
			INC(_a);
		};
	}forEach _vehicles;
	
	If (_a == count _vehicles) then {aufgabenstatus=false};
};

If (_geschafft) then {
	[_task,"succeeded"] call SHK_Taskmaster_upd;
	[-1,{["stadtconvkill",2] call FM(disp_localization)}] FMP;
}else{
	[_task,"failed"] call SHK_Taskmaster_upd;
	[-1,{["stadtconvkill",3] call FM(disp_localization)}] FMP;
};

{deleteVehicle _x}forEach _vehicles;
deleteMarker _start_mrkr;