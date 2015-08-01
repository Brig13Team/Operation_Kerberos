/*
	Author: iJesuz
	
	Description:
		spawnes a naval minefield
	
	Parameter(s):
		0 : ARRAY	- Centerposition of Minefield
		1 : SCALAR	- Radius
		2 : SCALAR	- Count of Mines
		3 : SCALAR	- Type (0 - Bottom, 1 - Surface, 2 - anchored (default), 3 - random)
*/
#include "script_component.hpp"

SCRIPT(spawn_naval_minefield);

private ["_pos", "_mine", "_marker", "_ret"];

params [["_position",[0,0,0],[[]],[3]], ["_radius",100,[0]], ["_count",25,[0]], ["_type",2,[0]]];

_ret = [];

for "_i" from 1 to _count do {
	_pos = [_position, _radius, 3] call FM(random_pos);

	if (_pos isEqualTo []) exitWith {};

	switch (_type) do {
		case 0: {
			_mine = createMine["UnderwaterMinePDM",_pos,[],0];
			_ret pushBack _mine;
		};
		case 1: {
			_mine = createMine["UnderwaterMineAB",_pos,[],0];
			_mine setPosATL _pos;
			_ret pushBack _mine;
		};
		case 3: {
			[_position, _radius, 1, floor (random 3)] call FM(spawn_naval_minefield);
		};
		default {
			_mine = createMine["UnderwaterMine",_pos,[],0];
			_depth = (getPosATL _mine) select 2;
			_height = floor ((ASLtoATL _pos) select 2);
			if (_height <= 2) then {
				_mine setPosATL [_pos select 0, _pos select 1, _depth - (_height / 2)];
			} else {
				_mine setPosATL [_pos select 0, _pos select 1, _depth - (random (_height-1))];
			};
			_ret pushBack _mine;
		};
	};
};

_ret
