/*
	Author: Dorbedo

	Description:
	Spawns Inf Patrols

	Parameter(s):
		0 :	ARRAY	- Position
		(optional)
		1 : NUMBER 	- Radius
		2 : NUMBER 	- Amount of Patrols
		

	Returns:
		Nothing

*/
#include "script_component.hpp"
SCRIPT(patrol_create);
params["_position",["_radius",1200,[0]],["_amount",0,[0]]];
LOG_4(_position,_radius,_amount,GVAR(group_patrol));
for "_i" from 0 to _amount do {
	private["_rad","_pos","_spawnpos","_grouptype","_group","_formation"];
	_rad = ((random 800) + 800);
	_pos = [_position,_radius,0] call EFUNC(common,pos_random);
	_spawnpos = _pos findEmptyPosition [1,40];
	_grouptype = GVAR(group_patrol) SELRND;
	LOG_3(_group,_spawnpos,_grouptype);
	if (_spawnpos isEqualTo []) then {
		ERROR("Keine Spawnposition");
	}else{
		_group = [_spawnpos, _grouptype] call FUNC(group);
		LOG_3(_group,_spawnpos,_grouptype);
		_formation = ["COLUMN","STAG COLUMN","WEDGE","VEE","FILE","DIAMOND"] SELRND;
		[_group, _spawnpos, "AWARE", "WHITE", "NORMAL", _formation, "", [5,10,15]] call EFUNC(spawn,patrol_task);
	};
};

