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
DEFAULT_PARAM(2,_centerdir,0);

for "_i" from 0 to ((count _spawnarray)-1) do {
	
	_typ = (_spawnarray select _i) select 0;
	_position = [	((((_spawnarray select _i) select 1)select 0) + (_centerpos select 0)),
				((((_spawnarray select _i) select 1)select 1) + (_centerpos select 1)),
				((((_spawnarray select _i) select 1)select 2) + (_centerpos select 2)) ];
<<<<<<< HEAD
	_position = [_centerpos,(_centerpos distance _position),_centerdir] call BIS_fnc_relPos;
	_dir = ((_spawnarray select _i) select 2) + _centerdir;
	_vehicle = _gruppe createVehicle [_typ,_position, [], _dir, "NONE"];
=======
	_dir = ((_spawnarray select _i) select 2);
	
	_vehicle = createVehicle [_typ,_position, [], _dir, "CAN_COLLIDE"];
	_vehicle setPosATL [(_position select 0),(_position select 1),0];
	_vehicle setDir _dir;
>>>>>>> origin/master
	
	If (_vehicle isKindOf "LandVehicle") then {
		If (!((crew _vehicle)isEqualTo [])) then {
			_gruppe = createGroup dorb_side;
			{_vehicle deleteVehicleCrew _x} forEach crew _vehicle;
			[_vehicle,_gruppe] call FM(spawn_crew);
		}else{
			_gruppe = createGroup dorb_side;
			[_vehicle,_gruppe] call FM(spawn_crew);
		};	
	};
	
};