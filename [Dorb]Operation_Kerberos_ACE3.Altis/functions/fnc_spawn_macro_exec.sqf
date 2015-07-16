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

	_spawndir = [_centerpos,_position] call BIS_fnc_dirTo;
	_position = [_centerpos,(_centerpos distance _position),(_spawndir+_centerdir)] call BIS_fnc_relPos;
	_dir = ((_spawnarray select _i) select 2) + _centerdir;

	_vehicle = createVehicle [_typ,_position, [], _dir, "CAN_COLLIDE"];
	_vehicle setPosATL [(_position select 0),(_position select 1),0];
	_vehicle setDir _dir;
	_vehicle setVectorUP (surfaceNormal _position);

	if (dorb_debug) then {
			_mrkr = createMarker [format["makro-%1-%2-%3",_i,_vehicle,_position],_position];
			_mrkr setMarkerShape "ICON";
			_mrkr setMarkerColor "ColorBlue";
			_mrkr setMarkerType "hd_dot";
	};
	
	
	
	If (_vehicle isKindOf "LandVehicle") then {
		_vehicle setFuel 0;
		_vehicle lock 3;
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