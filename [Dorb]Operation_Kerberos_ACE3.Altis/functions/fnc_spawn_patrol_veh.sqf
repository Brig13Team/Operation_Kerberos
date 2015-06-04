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
#include "script_component.hpp"

private ["_gruppe","_units","_rand"];
PARAMS_1(_position);
DEFAULT_PARAM(1,_radius,1200);
DEFAULT_PARAM(2,_anzahl_leicht,0);
DEFAULT_PARAM(3,_anzahl_schwer,0);
LOG_4(_position,_radius,_anzahl_leicht,_anzahl_schwer);

_vehicles=[];
_rand=[];
_einheit="";
for "_i" from 0 to (_anzahl_leicht) do {
	_rad = ((random 500) + 500);
	_pos = [_position, _radius,0] call FM(random_pos);
	
	_rand = (floor(random 8));
	if (_rand < 2) then {
		_einheit = dorb_veh_aa SELRND;
	}else{
		_einheit = dorb_veh_unarmored SELRND;
	};
	sleep 3;
	
	
	_spawnpos = _pos findEmptyPosition [1,100,_einheit];

	if (count _spawnpos < 1) then {
		ERROR(FORMAT_1("Keine Spawnposition | %1",_spawnpos));
	}else{
		LOG_3(_spawnpos,_einheit,dorb_side);
		_return = [_spawnpos,(random(360)),_einheit,dorb_side] call BIS_fnc_spawnVehicle;
		_vehicles pushBack (_return select 0);
		[(_return select 2), (getPos (_return select 0)), _rad, 7, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [5,10,15]] call CBA_fnc_taskPatrol;
		[(_return select 2)] call FM(moveToHC);
	};
};

for "_i" from 0 to (_anzahl_schwer) do {
	_rad = ((random 500) + 500);
	_pos = [_position, _radius,0] call FM(random_pos);
	
	_rand = (floor(random 8));
	if (_rand<2) then {
		_einheit = dorb_veh_aa SELRND;
	}else{
		_einheit = dorb_veh_armored SELRND;
	};
	_spawnpos = _pos findEmptyPosition [1,100,_einheit];
	if (count _spawnpos < 1) then {
		ERROR(FORMAT_1("Keine Spawnposition | %1",_spawnpos));
	}else{
		LOG_3(_spawnpos,_einheit,dorb_side);
		_return = [_spawnpos,(random(360)),_einheit,dorb_side] call BIS_fnc_spawnVehicle;
		_vehicles pushBack (_return select 0);
		[(_return select 2), (getPos (_return select 0)), _rad, 7, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [5,10,15]] call CBA_fnc_taskPatrol;
		[(_return select 2)] call FM(moveToHC);
	};
};

LOG(FORMAT_1("Spawned Vehicles \n %1",_vehicles));

if (dorb_debug) then {
	{
		_mrkr = createMarker [format["veh-%1",_x],getPos _x];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorRed";
		_mrkr setMarkerType "o_mech_inf";
		
	}forEach _vehicles;
};