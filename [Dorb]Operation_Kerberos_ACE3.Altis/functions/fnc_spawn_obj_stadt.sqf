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

LOG("Spawn Stadt");

//// makros has autodetection of RDS
[_position,600,(4+_difficulty),true] call FM(spawn_defence_macros);
[_position] spawn FM(spawn_commander);


_count_inf = 4;
_count_specops = 1;
_count_light = 3;
_count_tanks = 0;

If (_difficulty>1) then {
	_count_inf = 5;
	_count_specops = 2;
	_count_light = 5;
	_count_tanks = 2;
};

If (_difficulty>2) then {
	_count_inf = 6;
	_count_specops = 3;
	_count_light = 5;
	_count_tanks = 6;
};

If (worldName == "pja305") then {
	_count_specops = 0;
	_count_inf = _count_inf + 3;
	_count_light = (_count_light - 2) max 0;
	_count_tanks = (_count_tanks - 2) max 0;
};

LOG_5(_position,_count_inf,_count_specops,_count_light,_count_tanks);



_radius = 400;
_buildscount = count(_position nearObjects ["House", _radius]);

_units = 30;
_static = 5;
_multi = 1.2;

If (_buildscount > 75) then {
	_units = 40;
	_static = 10;
	_multi = 0.6;
};

If (_buildscount > 200) then {
	_units = 60;
	_static = 18;
	_multi = 0.2;
};

_count_specops = floor(_count_specops * _multi);
_count_inf = floor(_count_inf * _multi);
_count_light = floor(_count_light * _multi);
_count_tanks = floor(_count_tanks * _multi);


[_position,_radius,dorb_side,_units,_static,true,true,true,true] call dorb_fnc_city_fortify;
[_position,1500,_count_inf,_count_specops] call FM(spawn_patrol_inf);
[_position,1500,_count_light,_count_tanks] call FM(spawn_patrol_veh);
[_position,1500,-1,-1] call FM(spawn_patrol_water);

true
