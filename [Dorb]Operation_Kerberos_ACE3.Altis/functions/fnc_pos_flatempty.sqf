/*
	Author: Dorbedo

	Description:
		returns Array with Flat, Empty poisition

	Parameter(s):
		0 :	ARRAY	- Centerpos
		1 : SCALAR 	- Size
		2 : SCALAR	- Searchradius
		(optional)
		3 : SCALAR	- Precize Pos
		4 : SCALAR	- Gradient (0.14 == 14%)

	Returns:
	ARRAY : Array with Positions

	
*/
#include "script_component.hpp"

PARAMS_3(_position,_size,_searchradius);
DEFAULT_PARAM(3,_precizePos,0);
DEFAULT_PARAM(4,_maxGradient,0.15);

Private["_return","_searchpositions","_temp"];
_return = [];
_searchpositions = [_position,_searchradius,40] call FM(pos_surrounding);

for "_i" from 0 to (count _searchpositions) do {
	_temp = (_searchpositions select _i) isFlatEmpty [(_size/2),_precizePos,_maxGradient,_size,0,false];
	If ((IS_ARRAY(_temp))&&{!(_temp isEqualTo [])}) exitwith {_return = _temp;};
	_temp = [];
};
_return
