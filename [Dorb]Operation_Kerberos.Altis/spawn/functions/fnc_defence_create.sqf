/*
	Author: Dorbedo

	Description:
	Spawns defence Groups

	Parameter(s):
		0 :	ARRAY	- Position
		(optional)
		1 : NUMBER 	- Radius
		2 : NUMBER 	- Amount of Defence-Patrols
		

	Returns:
		Nothing

*/
#include "script_component.hpp"
SCRIPT(defence_create);
params["_position",["_radius",1200,[0]],["_amount",0,[0]]];

for "_i" from 0 to _amount do {
	private["_rad","_pos","_spawnpos","_grouptype","_group","_formation"];
	_rad = ((random 100) + 100);
	_pos = [_position,_radius,0] call EFUNC(common,pos_random);
	_spawnpos = _pos findEmptyPosition [1,40];
	_grouptype = GVAR(group_patrol) SELRND;

	if (_spawnpos isEqualTo []) then {
		ERROR("Keine Spawnposition");
	}else{
		_group = [_spawnpos, _grouptype] call FUNC(group);
		_formation = ["COLUMN","STAG COLUMN","WEDGE","VEE","FILE","DIAMOND"] SELRND;
		[_group, _spawnpos, "SAFE", "YELLOW", "LIMITED", _formation, "", [5,10,15]] call EFUNC(spawn,patrol_task);
	};
};

