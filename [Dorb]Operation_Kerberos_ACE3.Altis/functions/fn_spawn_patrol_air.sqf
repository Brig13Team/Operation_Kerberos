/*
	Author: Dorbedo

	Description:
	Spawns Air Patrols

	Parameter(s):
		0 :	ARRAY	- can be
		1 : NUMBER 	- maybe
		

	Returns:
	Something (eventually)

	
*/
#include "makros.hpp"

private ["_radius","_position","_anzahl_heli","_anzahl_plane","_gruppe","_units","_vehicles"];
_position = _this select 0;
_radius = [_this, 1, 1200,[0]] call BIS_fnc_Param;
_anzahl_heli = [_this, 2, 0,[0]] call BIS_fnc_Param;
_anzahl_plane = [_this, 3, 0,[0]] call BIS_fnc_Param;

d_log(FORMAT_4("VEH ATTACK| Pos=%1 / Radius=%2 / Anzahl Heli=%3 / Anzahl Flugzeug = %4 ",_position,_radius,_anzahl_heli,_anzahl_plane))

_vehicles=[];

for "_i" from 0 to _anzahl_heli do {
	_rad = ((random 500) + 200);
	_pos = [_position,_radius,0] FCALL(random_pos);
	_spawnpos = [(_pos select 0),(_pos select 1),400];
	_einheit = dorb_attack_heli_list SELRND;
	d_log(FORMAT_3("Spawnpos=%1 / einheit=%2 / dorb_side=%3",_spawnpos, _einheit, dorb_side))
	_return = [_spawnpos,(random(360)),_einheit,dorb_side] call BIS_fnc_spawnVehicle;
	_vehicles pushBack (_return select 0);
	[(_return select 2), (getPos (_return select 0)), _rad, 7, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [300,400,500]] call CBA_fnc_taskPatrol;
	[(_return select 2)] FCALL(moveToHC);
};

for "_i" from 0 to _anzahl_plane do {
	_rad = ((random 500) + 200);
	_pos = [_position,_radius,0] FCALL(random_pos);
	_spawnpos = [(_pos select 0),(_pos select 1),400];
	_einheit = dorb_patrol_air_list SELRND;
	d_log(FORMAT_3("Spawnpos=%1 / einheit=%2 / dorb_side=%3",_spawnpos, _einheit, dorb_side))
	_return = [_spawnpos,(random(360)),_einheit,dorb_side] call BIS_fnc_spawnVehicle;
	_vehicles pushBack (_return select 0);
	[(_return select 2), (getPos (_return select 0)), _rad, 7, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [300,400,500]] call CBA_fnc_taskPatrol;
	[(_return select 2)] FCALL(moveToHC);
};
d_log(FORMAT_1("Spawned Vehicles| ",_vehicles))

if (dorb_debug) then {
	{
		_mrkr = createMarker [format["infp-%1",_x],getPos (leader _x)];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorRed";
		_mrkr setMarkerType "o_inf";
		
	}forEach _vehicles;
};