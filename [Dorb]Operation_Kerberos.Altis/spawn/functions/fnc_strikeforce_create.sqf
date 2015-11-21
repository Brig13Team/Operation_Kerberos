/*
	Author: Dorbedo

	Description:
	Spawns Attackforce

	Parameter(s):
		0 :	ARRAY	- Position
		(optional)
		1 : NUMBER 	- Radius
		2 : NUMBER 	- Amount of strikeforce-Groups
		

	Returns:
		Nothing

*/
#include "script_component.hpp"
SCRIPT(strikeforce_create);
params["_centerposition",["_radius",600,[0]],["_amount",0,[0]]];

for "_i" from 0 to _amount do {
	private["_rad","_pos","_spawnpos","_grouptype","_group","_formation"];
	_rad = ((random 600) + 200);
	_pos = [_position,_radius,0] call EFUNC(common,pos_random);
	_spawnpos = _pos findEmptyPosition [1,40];
	_grouptype = GVAR(group_strikeforce) SELRND;

	if (_spawnpos isEqualTo []) then {
		ERROR("Keine Spawnposition");
	}else{
		_group = [_spawnpos, _grouptype] call FUNC(group);
		[_group] call EFUNC(ai,hq_registerGroup);
	};
};

