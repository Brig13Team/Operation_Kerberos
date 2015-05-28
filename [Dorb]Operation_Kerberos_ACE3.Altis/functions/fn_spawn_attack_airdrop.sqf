/*
	Author: Dorbedo
	
	Description:
	
	Requirements:
	
	Parameter(s):
		0 : ARRAY	- Example
		1 : ARRAY	- Example
		2 : STRIN	- Example
	
	Return
	BOOL
*/
#include "makros.hpp"
CHECK(!isServer)

private ["_position","_type","_dropradius","_spawnpos","_spawnradius","_dir","_flughoehe","_einheit","_transporter","_jaeger_gruppe","_jaeger","_platzanzahl"];

_position 		= _this select 0;
_type 			= [_this, 1, 0,[0]] call BIS_fnc_Param;
_dropradius 	= [_this, 2, 200,[0]] call BIS_fnc_Param;
_spawnradius 	= [_this, 3, 2000,[0]] call BIS_fnc_Param;
_flughoehe 		= [_this, 4, 190,[0]] call BIS_fnc_Param;

d_log(FORMAT_5("PARADROP| Pos=%1 / Type=%2 / Dropradius=%3 / Spawnradius = %4 / Flughoehe=%5",_position,_type,_dropradius,_spawnradius,_flughoehe))


_position = [_position,100,0] FCALL(random_pos);

sleep (random 9);
_spawnpos = [_position,_spawnradius,1] FCALL(random_pos);
_spawnpos_inf = _spawnpos;
_spawnpos set [2,_flughoehe];
_dir = [_spawnpos, _position] call BIS_fnc_dirTo;
_einheit = dorb_transport_heli_list call BIS_fnc_selectRandom;
d_log(FORMAT_4("Spawnpos=%1 / dir=%2 / einheit=%3 / dorb_side=%4",_spawnpos, _dir, _einheit, dorb_side))

_spawn_array = [_spawnpos, _dir, _einheit, dorb_side] call BIS_fnc_spawnVehicle;
_transporter = _spawn_array select 0;

_transporter setpos [_spawnpos];
_transporter flyInHeight _flughoehe;
_transporter setSpeedMode "FULL";
_transporter setBehaviour "CARELESS";


if (dorb_debug) then {
	_mrkr = createMarker [format["airdrop-%1",_transporter],_spawnpos];
	_mrkr setMarkerShape "ICON";
	_mrkr setMarkerColor "ColorRed";
	_mrkr setMarkerType "o_plane";
};



_jaeger_gruppe = createGroup dorb_side;
_jaeger_gruppe setCombatMode "RED";
_platzanzahl = _transporter emptyPositions "cargo";
for "_i" from 0 to (_platzanzahl - 2) do {
	_einheit = dorb_menlist call BIS_fnc_selectRandom;
	_jaeger = [[(_spawnpos select 0),(_spawnpos select 1),0],_jaeger_gruppe,_einheit] FCALL(spawn_unit);
	//sleep 0.1;
	
	//_jaeger assignAsCargo _transporter;
	//_jaeger assignAsCargo  [_transporter, _i];
	//sleep 0.3;
	//_jaeger moveInCargo _transporter;
	//_jaeger moveInCargo _transporter;
	//sleep 0.4;
	//_jaeger disableAI "Move";
	
};

sleep 1;

{
	_x assignAsCargo _transporter;
	_x moveInCargo _transporter;
}forEach units _jaeger_gruppe;

[_jaeger_gruppe, _position, 400, 5, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [5,10,15]] call CBA_fnc_taskPatrol;

sleep 2;
(_spawn_array select 2) addWaypoint [_position,100];
(_spawn_array select 2) addWaypoint [_spawnpos,100];

If (_type < 1) then {
	while {(alive _transporter) and (canMove _transporter)} do {
		//_transporter addWaypoint [_position,100];
		//_transporter doMove _position;
		//sleep 4;
		_transporter doMove _position;
		d_log(FORMAT_1("Entfernung=%1",_transporter distance _position))
		//d_log(FORMAT_1("Flughoehe=%1",ADD(_flughoehe,100)))
		
		waitUntil {((_transporter distance _position) < (_flughoehe + 100))};
			{
				_x enableAI "Move";
				unassignVehicle (_x);
				_x allowDamage false;
				moveOut _x;
				sleep 0.1;
				_fallschirm = createVehicle ["NonSteerable_Parachute_F",(getPos _x), [], 0, "FLY"];
				_x moveInDriver _fallschirm;
				sleep 0.1;
				_x allowDamage true;		
			} forEach units _jaeger_gruppe;
		//[_jaeger_gruppe, _position, 400, 5, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [5,10,15]] call CBA_fnc_taskPatrol;
		[_jaeger_gruppe] FCALL(moveToHC);
		_transporter domove _spawnpos;
		waitUntil {((_transporter distance _spawnpos) < (_flughoehe + 100))};
		if (true) exitWith {};
	};
	{deletevehicle _x} foreach crew _transporter;
	deletevehicle _transporter;
}else{
	_transporter doMove _position;
	waitUntil {((_transporter distance _position) < (_flughoehe + 100))};
	_jaeger_gruppe leaveVehicle _transporter;
	waitUntil {(_transporter emptyPositions "cargo" == _platzanzahl)};
	[_jaeger_gruppe, _position, 400, 5, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [5,10,15]] call CBA_fnc_taskPatrol;
	_transporter domove _spawnpos;
	waitUntil {((_transporter distance _spawnpos) < (_flughoehe + 100))};
	{deletevehicle _x} foreach crew _transporter;
	deletevehicle _transporter;
};

