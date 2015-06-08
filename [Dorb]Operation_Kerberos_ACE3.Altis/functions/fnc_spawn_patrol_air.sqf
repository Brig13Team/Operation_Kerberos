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
#include "script_component.hpp"

private ["_gruppe","_units","_vehicles","_rad","_pos","_spawnpos","_einheit","_return"];
PARAMS_1(_position);
DEFAULT_PARAM(1,_radius,1200);
DEFAULT_PARAM(2,_anzahl_heli,0);
DEFAULT_PARAM(3,_anzahl_plane,0);
LOG_4(_position,_radius,_anzahl_heli,_anzahl_plane);

_vehicles=[];

for "_i" from 0 to _anzahl_heli do {
	_rad = ((random 500) + 200);
	_pos = [_position,_radius,0] call FM(random_pos);
	_spawnpos = [(_pos select 0),(_pos select 1),400];
	_einheit = dorb_attack_heli_list SELRND;
	LOG_3(_spawnpos,_einheit,dorb_side);
	_return = [_spawnpos,(random(360)),_einheit,dorb_side] call BIS_fnc_spawnVehicle;
	_vehicles pushBack (_return select 0);
	[(_return select 2), (getPos (_return select 0)), _rad, 7, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [300,400,500]] call CBA_fnc_taskPatrol;
	[(_return select 2)] call FM(moveToHC);
};

for "_i" from 0 to _anzahl_plane do {
	_rad = ((random 500) + 200);
	_pos = [_position,_radius,0] call FM(random_pos);
	_spawnpos = [(_pos select 0),(_pos select 1),400];
	_einheit = dorb_patrol_air_list SELRND;
	LOG_3(_spawnpos,_einheit,dorb_side);
	_return = [_spawnpos,(random(360)),_einheit,dorb_side] call BIS_fnc_spawnVehicle;
	_vehicles pushBack (_return select 0);
	[(_return select 2), (getPos (_return select 0)), _rad, 7, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [300,400,500]] call CBA_fnc_taskPatrol;
	[(_return select 2)] call FM(moveToHC);
};
LOG(FORMAT_1("Spawned Vehicles: \n %1 ",_vehicles));

if (dorb_debug) then {
	private "_mrkr";
	{
		_mrkr = createMarker [format["infp-%1",_x],getPos (leader _x)];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorRed";
		_mrkr setMarkerType "o_inf";
		
	}forEach _vehicles;
};