/*
	Author: Dorbedo

	Description:
		Spawns predefined defencepositions

	Parameter(s):
		0 :	ARRAY	- Startpos
		1 : ARRAY 	- Array with objects


*/
#include "script_component.hpp"

DEFAULT_PARAM(0,_centerpos,[]);
CHECK(_centerpos isEqualTo [])
DEFAULT_PARAM(1,_spawnarray,[]);

for "_i" from 0 to ((count _spawnarray)-1) do {
	
	_gruppe = createGroup dorb_side;
	_typ = (_spawnarray select _i) select 0;
	_position = [	((((_spawnarray select _i) select 1)select 0) + (_centerpos select 0))
				((((_spawnarray select _i) select 1)select 1) + (_centerpos select 1))
				((((_spawnarray select _i) select 1)select 2) + (_centerpos select 2)) ];
	_dir = ((_spawnarray select _i) select 2);
	_vehicle = _gruppe createVehicle [_typ,_position, [], _dir, "NONE"];
	
	If (_vehicle isKindOf "LandVehicle") then {
		If (!((crew _vehicle)isEqualTo [])) then {
			{_vehicle deleteVehicleCrew _x} forEach crew _vehicle;
			[_vehicle,dorb_side] call FM(spawn_crew);
		}else{
			[_vehicle,dorb_side] call FM(spawn_crew);
		};	
	};
	
};