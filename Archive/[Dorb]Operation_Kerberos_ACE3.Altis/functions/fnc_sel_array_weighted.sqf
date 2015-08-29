/*
	Author: Dorbedo
	
	Description:
		Selects weighted from an array
	
	Parameter(s):
		0 : ARRAY	- Array to choose from
		1 : SCALAR	- Pos of Weight inside Element
		2 : BOOL	- Return just the Pos of the Element
	
*/
#include "script_component.hpp"
SCRIPT(sel_array_weighted);
params[["_array",[],[[]]],["_weightpos",-1,[0]],["_returnPos",false,[true]]];
CHECK(_array isEqualTo [])
CHECK(_weightpos<0)
private["_weightsum","_i","_choosenWeight"];
_weightsum = 0;

{
	_weightsum = _weightsum + abs(_x select _weightpos);
}forEach _array;

_weightsum = _weightsum * 1000;
_choosenWeight = floor(random _weightsum);
If (_choosenWeight != 0) then {_choosenWeight = _choosenWeight / 1000;};

_i = 0;
_weightsum = 0;
{
	_weightsum = _weightsum + abs(_x select _weightpos);
	If (_weightsum > _choosenWeight) exitWith {};
	_i = _forEachIndex;
}forEach _array;

If (_returnPos) exitWith {_i};
(_array select _i)
