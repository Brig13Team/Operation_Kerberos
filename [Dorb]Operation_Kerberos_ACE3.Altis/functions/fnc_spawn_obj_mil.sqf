/*
	Author: Dorbedo

	Description:
	Units Obj "Mil"
	
	Parameter(s):
		0 :	ARRAY - Position
		
*/
#include "script_component.hpp"

PARAMS_1(_position);

[_position,800,5,0] spawn FM(spawn_patrol_inf);	sleep 10;
[_position,1200,3,0] spawn FM(spawn_patrol_veh);	sleep 9;

If (_difficulty > 1) then {
	[_position,800,4,0] spawn FM(spawn_patrol_inf);	sleep 10;
	[_position,1200,2,2] spawn FM(spawn_patrol_veh);	sleep 8;
};
If (_difficulty > 2) then {
	[_position,800,3,0] spawn FM(spawn_patrol_inf);	sleep 10;
	[_position,1200,0,3] spawn FM(spawn_patrol_veh);	sleep 10;
	//[_position,1500,1,0] spawn FM(spawn_patrol_air);	sleep 7;
};
/*
If (_difficulty > 3) then {
	[_position,800,0,1] spawn FM(spawn_patrol_inf);	sleep 10;
	[_position,1200,0,2] spawn FM(spawn_patrol_veh);	sleep 10;
	[_position,1500,1,2] spawn FM(spawn_patrol_air);	sleep 11;
};
If (_difficulty > 4) then {
	[_position,800,1,2] spawn FM(spawn_patrol_inf);	sleep 10;
	[_position,1200,0,2] spawn FM(spawn_patrol_veh);	sleep 10;
	[_position,1500,1,1] spawn FM(spawn_patrol_air);	sleep 12;
};
*/
for "_i" from 0 to 1 do {
	_spawnposition = [_position,200,0] call FM(random_pos);
	[_spawnposition] spawn FM(spawn_tower);
	sleep 5;
};
for "_i" from 0 to 1 do {
	_spawnposition = [_position,200,0] call FM(random_pos);
	[_spawnposition] spawn FM(spawn_mortarpos);
	sleep 5;
};

[_position] spawn FM(spawn_commandveh);
If (_difficulty>2) then {
	[_position] spawn FM(spawn_commandveh);
};

_position spawn {
	_rad = 200;
	_difficulty = call FM(dyn_difficulty);
	_gebaeudepos_arr = [];
	_gebaeudepos_arr = [_this,_rad] call FM(get_buildings);
	
	_gebaeudepos_arr = [_gebaeudepos_arr,5,(8+_difficulty)] call FM(spawn_rooftop);
	_gebaeudepos_arr = [_gebaeudepos_arr,(20 + (_difficulty*5)),(30 + (_difficulty*5))] spawn FM(spawn_in_building);
};