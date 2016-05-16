/*
	Author: Dorbedo

	Description:
		spawn enemys for mission "Military"
	
	Parameter(s):
		0 :	ARRAY - Position
		
*/
#include "script_component.hpp"
SCRIPT(mil);
private["_position","_difficulty","_spawnposition","_rand"];
PARAMS_1(_position);
_difficulty = [] call EFUNC(mission,dyn_difficulty);

LOG("Spawn Military-Area");
LOG_1(_difficulty);

//// makros has autodetection of RDS
[_position,1200,(4+_difficulty)] call FUNC(defence_macros);
[_position] spawn EFUNC(ai,commander_init);


_count_inf = 5;
_count_specops = 0;
_count_light = 3;
_count_tanks = 0;

If (_difficulty>1) then {
	_count_inf = 7;
	_count_specops = 0;
	_count_light = 5;
	_count_tanks = 2;
};

If (_difficulty>2) then {
	_count_inf = 10;
	_count_specops = 0;
	_count_light = 5;
	_count_tanks = 5;
};

If (worldName == "pja305") then {
	_count_specops = 0;
	_count_inf = _count_inf + 3;
	_count_light = (_count_light - 2) max 0;
	_count_tanks = (_count_tanks - 2) max 0;
};

LOG_5(_position,_count_inf,_count_specops,_count_light,_count_tanks);

[_position,800,_count_inf,_count_specops] call FUNC(patrol_inf);
[_position,1200,_count_light,_count_tanks] call FUNC(patrol_veh);
//[_position,1200,-1,-1] call FUNC(patrol_water);
[_position,1300,3] call FUNC(minefields);
/*
[_position,_difficulty] spawn {
	_gebaeudepos_arr = [];
	_gebaeudepos_arr = [(_this select 0),200] call EFUNC(common,get_buildings);
	
	_gebaeudepos_arr = [_gebaeudepos_arr,5,(8+(_this select 1))] call FUNC(rooftop);
	_gebaeudepos_arr = [_gebaeudepos_arr,(20 + ((_this select 1)*5)),(30 + ((_this select 1)*5))] spawn FUNC(in_building);
};
*/

true
