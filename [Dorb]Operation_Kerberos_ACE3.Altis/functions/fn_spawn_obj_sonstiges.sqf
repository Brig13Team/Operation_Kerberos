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

private["_position","_difficulty","_spawnposition","_rand"];

_position = _this select 0;
_difficulty = [] call dorb_fnc_difficulty;

d_log(FORMAT_1("Spawn Sonstiges / Pos=%1",_position))


[_position,800,6,1] FSPAWN(spawn_patrol_inf);	sleep 10;
[_position,1200,3,0] FSPAWN(spawn_patrol_veh);	sleep 10;

If (_difficulty > 1) then {
	[_position,800,3,2] FSPAWN(spawn_patrol_inf);	sleep 10;
	[_position,1200,2,2] FSPAWN(spawn_patrol_veh);	sleep 10;
};
If (_difficulty > 2) then {
	[_position,800,2,2] FSPAWN(spawn_patrol_inf);	sleep 10;
	[_position,1200,0,4] FSPAWN(spawn_patrol_veh);	sleep 10;
	//[_position,1500,1,0] FSPAWN(spawn_patrol_air);	sleep 10;
};
/*
If (_difficulty > 3) then {
	[_position,800,0,1] FSPAWN(spawn_patrol_inf);	sleep 10;
	[_position,1200,0,3] FSPAWN(spawn_patrol_veh);	sleep 10;
//	[_position,1500,1,2] FSPAWN(spawn_patrol_air);	sleep 10;
};
If (_difficulty > 4) then {
	[_position,800,0,1] FSPAWN(spawn_patrol_inf);	sleep 10;
	[_position,1200,0,3] FSPAWN(spawn_patrol_veh);	sleep 10;
	//[_position,1500,1,1] FSPAWN(spawn_patrol_air);	sleep 10;
};
*/
d_log("Spawn Sonstiges Macros")

_spawnposition=[];
for "_i" from 0 to (2) do {
	_rand = (floor(random 3));
	sleep 15;
	
	switch (_rand) do {
		case 0;
		case 1 : {
			_spawnposition = [_position,200,0] FCALL(random_pos);
			[_spawnposition] FSPAWN(spawn_tower);
			};
		case 2 : {
			_spawnposition = [_position,800,1] FCALL(random_pos);
			[_spawnposition] FSPAWN(spawn_mortarpos);
		};
	};
};

[_position] FSPAWN(spawn_commandveh);
If (_difficulty>2) then {
	[_position] FSPAWN(spawn_commandveh);
};

d_log("Spawn sonstiges fertig")
true