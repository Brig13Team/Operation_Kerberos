/*
	Author: Dorbedo
	
	Description:
		spawn enemys for mission "Sonstiges"
	
	Parameter(s):
		0 : ARRAY	- Posistion
	
*/
#include "script_component.hpp"
private["_position","_difficulty","_spawnposition","_rand"];
PARAMS_1(_position);
_difficulty = [] call FM(dyn_difficulty);

LOG("Spawn Sonstiges");
LOG_1(_difficulty);

//// makros has autodetection of RDS
[_position] spawn FM(spawn_commander);


_count_inf = 4;
_count_specops = 1;
_count_light = 3;
_count_tanks = 0;
_count_defence = 5;

If (_difficulty>1) then {
	_count_inf = 6;
	_count_specops = 3;
	_count_light = 5;
	_count_tanks = 2;
	_count_defence = 7;
};

If (_difficulty>2) then {
	_count_inf = 8;
	_count_specops = 3;
	_count_light = 5;
	_count_tanks = 6;
	_count_defence = 9;
};

If (worldName == "pja305") then {
	_count_specops = 0;
	_count_inf = _count_inf + 3;
	_count_light = (_count_light - 2) max 0;
	_count_tanks = (_count_tanks - 2) max 0;
	_count_defence = 6;
};

LOG_5(_position,_count_inf,_count_specops,_count_light,_count_tanks);

[_position,1200,_count_defence] call FM(spawn_defence_macros);
[_position,1200,_count_inf,_count_specops] call FM(spawn_patrol_inf);
[_position,1200,_count_light,_count_tanks] call FM(spawn_patrol_veh);
[_position,1200,-1,-1] call FM(spawn_patrol_water);
[_position,1300,8] call FM(spawn_minefields);

true