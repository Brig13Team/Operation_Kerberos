/*
	Author: Dorbedo

	Description:
		returns Array with Positions from a Square

	Parameter(s):
		0 :	ARRAY	- Centerpos
		1 : SCALAR 	- Step
		2 : SCALAR	- lenght in X
		3 : SCALAR	- lenght in Y

	Returns:
	ARRAY : Array with Positions

*/
#include "script_component.hpp"
SCRIPT(pos_square);
params[["_position",[],[[]],[2,3]],["_step",30,[0]],["_sideX",600,[0]],["_sideY",-1,[0]]];
CHECKRET((_position isEqualTo []),[]);
If ((_step < 10)||(_sideX < 21)) exitWith {[_position]};
If (_sideY < 0) then {_sideY=_sideX;};
private ["_startpos","_return"];
_startpos = [((_position select 0)-(_sideX*0.5)),((_position select 1)-(_sideY*0.5)),0];
_return = [];

for "_i" from 0 to (floor(_sideX/_step)) do {
	for "_j" from 0 to (floor(_sideY/_step)) do {
		_return pushBack [(_startpos select 0)+(_i*_step),(_startpos select 1)+(_j*_step),0];
	};
};

[[_position,_step,_sideX,_sideY],_return];






