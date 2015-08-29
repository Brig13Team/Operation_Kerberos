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


PARAMS_2(_position,_gebaeudepos_arr);
private["_difficulty"];
LOG(FORMAT_2("Spawn Stadt \n Pos=%1 \n Gebauedearr=%2",_position,_gebaeudepos_arr));

_difficulty = [] call FM(dyn_difficulty);

If (worldName == "pja305") exitWith {

	[_position,1200,7,1] spawn FM(spawn_patrol_inf);	sleep 10;
	[_position,1000,2,0] spawn FM(spawn_patrol_veh);	sleep 10;

	If (_difficulty > 1) then {
		[_position,1200,4,0] spawn FM(spawn_patrol_inf);	sleep 10;
		[_position,1000,1,2] spawn FM(spawn_patrol_veh);	sleep 10;
	};
	If (_difficulty > 2) then {
		[_position,1200,2,2] spawn FM(spawn_patrol_inf);	sleep 10;
		[_position,1000,0,3] spawn FM(spawn_patrol_veh);	sleep 10;
	};

	[_position] spawn FM(spawn_commandveh);
	
	If (DORB_MODS_RDS) then {
		[_position] spawn {
			_position = _this select 0;
			for "_i" from 0 to 8 do {
				_spawnposition = [_position,800,0] call FM(random_pos);
				[_spawnposition] spawn FM(spawn_aapos);
				sleep 5;
			};
		};
	};
	[_gebaeudepos_arr,_difficulty] spawn {
		private["_difficulty","_gebaeudepos_arr"];
		_gebaeudepos_arr = _this select 0;
		_difficulty = _this select 1;
		_gebaeudepos_arr = [_gebaeudepos_arr,8,(8+_difficulty)] call FM(spawn_rooftop);
		[_gebaeudepos_arr,15,(40 + (_difficulty*2))] spawn FM(spawn_in_building);
	};
};

If (worldName == "Panthera3") then {
	If (DORB_MODS_RDS) then {
		[_position] spawn {
			_position = _this select 0;
			for "_i" from 0 to 5 do {
				_spawnposition = [_position,800,0] call FM(random_pos);
				[_spawnposition] spawn FM(spawn_aapos);
				sleep 5;
			};
		};
	};
};






[_position,800,5,1] spawn FM(spawn_patrol_inf);	sleep 10;
[_position,1000,2,0] spawn FM(spawn_patrol_veh);	sleep 10;

If (_difficulty > 1) then {
	[_position,800,3,2] spawn FM(spawn_patrol_inf);	sleep 10;
	[_position,1000,1,1] spawn FM(spawn_patrol_veh);	sleep 10;
};
If (_difficulty > 2) then {
	[_position,800,2,2] spawn FM(spawn_patrol_inf);	sleep 10;
	[_position,1000,0,3] spawn FM(spawn_patrol_veh);	sleep 10;
};

/*
[_position,1000,4,2] spawn FM(spawn_patrol_veh);
sleep 10;
[_position,800,10,4] spawn FM(spawn_patrol_inf);
sleep 10;
*/
[_position] spawn FM(spawn_commandveh);

[_gebaeudepos_arr,_difficulty] spawn {
	private["_difficulty","_gebaeudepos_arr"];
	_gebaeudepos_arr = _this select 0;
	_difficulty = _this select 1;
	
	_gebaeudepos_arr = [_gebaeudepos_arr,5,(8+_difficulty)] call FM(spawn_rooftop);
	[_gebaeudepos_arr,15,(40 + (_difficulty*2))] call FM(spawn_in_building);
};


