/*
	Author: Dorbedo

	Description:
	Creates a vehicle Patrol

	Parameter(s):
		0 :	ARRAY	- can be
		1 : NUMBER 	- maybe
		

	Returns:
	Something (eventually)
	
*/
#include "makros.hpp"

private ["_radius","_position","_anzahl_leicht","_anzahl_schwer","_gruppe","_units","_rand"];
_position = _this select 0;
_radius = [_this, 1, 1200,[0]] call BIS_fnc_Param;
_anzahl_leicht = [_this, 2, 0,[0]] call BIS_fnc_Param;
_anzahl_schwer = [_this, 3, 0,[0]] call BIS_fnc_Param;

d_log(FORMAT_4("VEH PATROL| Pos=%1 / Radius=%2 / Anzahl Leichte=%3 / Anzahl Schwere = %4 ",_position,_radius,_anzahl_leicht,_anzahl_schwer))

_vehicles=[];
_rand=[];
_einheit="";
for "_i" from 0 to (_anzahl_leicht) do {
	_rad = ((random 500) + 500);
	_pos = [_position, _radius,0] call dorb_fnc_random_pos;
	
	_rand = (floor(random 8));
	if (_rand < 2) then {
		_einheit = dorb_veh_aa SELRND;
	}else{
		_einheit = dorb_veh_unarmored SELRND;
	};
	sleep 3;
	
	
	_spawnpos = _pos findEmptyPosition [1,100,_einheit];

	if (count _spawnpos < 1) then {
		d_error(FORMAT_1("Keine Spawnposition | ",_spawnpos))
	}else{
		d_log(FORMAT_3("Spawnpos=%1 / einheit=%2 / dorb_side=%3",_spawnpos, _einheit, dorb_side))
		_return = [_spawnpos,(random(360)),_einheit,dorb_side] call BIS_fnc_spawnVehicle;
		_vehicles pushBack (_return select 0);
		[(_return select 2), (getPos (_return select 0)), _rad, 7, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [5,10,15]] call CBA_fnc_taskPatrol;
		[(_return select 2)] FCALL(moveToHC);
	};
};

for "_i" from 0 to (_anzahl_leicht) do {
	_rad = ((random 500) + 500);
	_pos = [_position, _radius,0] FCALL(random_pos);
	
	_rand = (floor(random 8));
	if (_rand<2) then {
		_einheit = dorb_veh_aa SELRND;
	}else{
		_einheit = dorb_veh_armored SELRND;
	};
	_spawnpos = _pos findEmptyPosition [1,100,_einheit];
	if (count _spawnpos < 1) then {
		d_error(FORMAT_1("Keine Spawnposition | ",_spawnpos))
	}else{
		d_log(FORMAT_3("Spawnpos=%1 / einheit=%2 / dorb_side=%3",_spawnpos, _einheit, dorb_side))
		_return = [_spawnpos,(random(360)),_einheit,dorb_side] call BIS_fnc_spawnVehicle;
		_vehicles pushBack (_return select 0);
		[(_return select 2), (getPos (_return select 0)), _rad, 7, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [5,10,15]] call CBA_fnc_taskPatrol;
		[(_return select 2)] FCALL(moveToHC);
	};
};

d_log(FORMAT_1("Spawned Vehicles| ",_vehicles))

if (dorb_debug) then {
	{
		_mrkr = createMarker [format["veh-%1",_x],getPos _x];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorRed";
		_mrkr setMarkerType "o_mech_inf";
		
	}forEach _vehicles;
};