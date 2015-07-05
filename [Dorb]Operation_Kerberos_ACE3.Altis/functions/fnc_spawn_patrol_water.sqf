/*
	Author: Dorbedo

	Description:
	Spawns Air Patrols

	Parameter(s):
		0 :	ARRAY	- Spawnposition
		1 : SCALAR 	- Radius
		2 : SCALAR	- number of boats (-1 = automatic)
		3 : SCALAR	- nuber of divers (-1 = automatic)
		

	Returns:
	Something (eventually)

	
*/
#include "script_component.hpp"

private ["_gruppe","_units","_vehicles","_rad","_pos","_spawnpos","_einheit","_return"];
PARAMS_1(_position);
DEFAULT_PARAM(1,_radius,1200);
DEFAULT_PARAM(2,_anzahl_boats,0);
DEFAULT_PARAM(3,_anzahl_diver,0);
_amountOfWater = 0;
//If  ((_anzahl_boats<0)||(_anzahl_diver<0)) then {
	_searchposarray = [_position];
	_searchrad = 1;
	_step = 50;
	_s = 0;
	while {_searchrad < _radius} do {
		_umfang = 2 * pi * _searchrad;
		_theta = _s*_radius;
		_searchposarray pushBack ([_position, _searchrad, _theta] call BIS_fnc_relPos);
		_s=_s+_step;
		If (_s > _umfang) then {
			_searchrad = _searchrad + _step;
			_s=0;
		};
	};
	
	_amountOfWater = {surfaceIsWater _x}count _searchposarray;
//};
/// exit if there is only a small amount of water
CHECK(_amountOfWater<5)



_vehicles=[];

for "_i" from 0 to _anzahl_boats do {
	_rad = ((random 200) + 100);
	_pos = [_position,_radius,3] call FM(random_pos);
	_spawnpos = [(_pos select 0),(_pos select 1),400];
	If (!(_spawnpos isEqualTo [])) then {
		_einheit = dorb_patrolboatlist SELRND;
		_return = [_spawnpos,(random(360)),_einheit,dorb_side] call BIS_fnc_spawnVehicle;
		_vehicles pushBack (_return select 0);
		[(_return select 2), (getPos (_return select 0)), _rad, 7, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [300,400,500]] call CBA_fnc_taskPatrol;
		[(_return select 2)] call FM(moveToHC);	
	};
};

for "_i" from 0 to _anzahl_diver do {
	_rad = ((random 200) + 100);
	_pos = [_position,_radius,3] call FM(random_pos);
	_spawnpos = [(_pos select 0),(_pos select 1),400];
	If (!(_spawnpos isEqualTo [])) then {
		_einheit = dorb_diverlist SELRND;
		_return = [_spawnpos,(random(360)),_einheit,dorb_side] call BIS_fnc_spawnVehicle;
		_vehicles pushBack (_return select 0);
		[(_return select 2), (getPos (_return select 0)), _rad, 7, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [300,400,500]] call CBA_fnc_taskPatrol;
		[(_return select 2)] call FM(moveToHC);
	};
};





