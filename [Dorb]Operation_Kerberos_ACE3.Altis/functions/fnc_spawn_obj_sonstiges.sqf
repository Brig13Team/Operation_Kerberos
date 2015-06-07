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
#include "script_component.hpp"

private["_position","_difficulty","_spawnposition","_rand"];
PARAMS_1(_position);
_difficulty = [] call FM(dyn_difficulty);

LOG(FORMAT_1("Spawn Sonstiges \n Pos=%1",_position));

If (worldName == "pja305") exitWith {
	
	[_position,1200,6,0] spawn FM(spawn_patrol_inf);	sleep 10;
	[_position,1200,6,0] spawn FM(spawn_patrol_veh);	sleep 10;

	If (_difficulty > 1) then {
		[_position,1200,3,0] spawn FM(spawn_patrol_inf);	sleep 10;
		[_position,1200,4,2] spawn FM(spawn_patrol_veh);	sleep 10;
	};
	If (_difficulty > 2) then {
		[_position,1200,4,0] spawn FM(spawn_patrol_inf);	sleep 10;
		[_position,1200,2,4] spawn FM(spawn_patrol_veh);	sleep 10;
		//[_position,1500,1,0] spawn FM(spawn_patrol_air);	sleep 10;
	};
	for "_i" from 0 to 8 do {
		_spawnposition = [_position,1200,0] call FM(random_pos);
		[_spawnposition] spawn FM(spawn_aapos);
		sleep 5;
	};
	LOG("Spawn Sonstiges Macros");

	_spawnposition=[];
	for "_i" from 0 to (2) do {
		_rand = (floor(random 3));
		sleep 15;
		
		switch (_rand) do {
			case 0;
			case 1 : {
				_spawnposition = [_position,200,0] call FM(random_pos);
				[_spawnposition] spawn FM(spawn_tower);
				};
			case 2 : {
				_spawnposition = [_position,800,1] call FM(random_pos);
				[_spawnposition] spawn FM(spawn_mortarpos);
			};
		};
	};

	[_position] spawn FM(spawn_commandveh);
	sleep 5;
	If (_difficulty>2) then {
		[_position] spawn FM(spawn_commandveh);
	};

	LOG("Spawn sonstiges fertig");
	true
};
[_position,800,6,1] spawn FM(spawn_patrol_inf);	sleep 10;
[_position,1200,3,0] spawn FM(spawn_patrol_veh);	sleep 10;

If (_difficulty > 1) then {
	[_position,800,3,2] spawn FM(spawn_patrol_inf);	sleep 10;
	[_position,1200,2,2] spawn FM(spawn_patrol_veh);	sleep 10;
};
If (_difficulty > 2) then {
	[_position,800,2,2] spawn FM(spawn_patrol_inf);	sleep 10;
	[_position,1200,0,4] spawn FM(spawn_patrol_veh);	sleep 10;
	//[_position,1500,1,0] spawn FM(spawn_patrol_air);	sleep 10;
};
/*
If (_difficulty > 3) then {
	[_position,800,0,1] spawn FM(spawn_patrol_inf);	sleep 10;
	[_position,1200,0,3] spawn FM(spawn_patrol_veh);	sleep 10;
//	[_position,1500,1,2] spawn FM(spawn_patrol_air);	sleep 10;
};
If (_difficulty > 4) then {
	[_position,800,0,1] spawn FM(spawn_patrol_inf);	sleep 10;
	[_position,1200,0,3] spawn FM(spawn_patrol_veh);	sleep 10;
	//[_position,1500,1,1] spawn FM(spawn_patrol_air);	sleep 10;
};
*/
LOG("Spawn Sonstiges Macros");

_spawnposition=[];
for "_i" from 0 to (2) do {
	_rand = (floor(random 3));
	sleep 15;
	
	switch (_rand) do {
		case 0;
		case 1 : {
			_spawnposition = [_position,200,0] call FM(random_pos);
			[_spawnposition] spawn FM(spawn_tower);
			};
		case 2 : {
			_spawnposition = [_position,800,1] call FM(random_pos);
			[_spawnposition] spawn FM(spawn_mortarpos);
		};
	};
};

[_position] spawn FM(spawn_commandveh);
sleep 5;
If (_difficulty>2) then {
	[_position] spawn FM(spawn_commandveh);
};

LOG("Spawn sonstiges fertig");
true