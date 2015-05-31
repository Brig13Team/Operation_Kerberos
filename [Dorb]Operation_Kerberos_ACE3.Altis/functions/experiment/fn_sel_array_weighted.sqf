/*
	Author: Dorbedo
	
	Description:
		Selects weighted from an array
	
	Parameter(s):
		0 : ARRAY	- Array to choose from
		1 : ARRAY	- Array with the Weights
	
*/
#include "script_component.hpp"


_array = [_this,0,[],[[]]] call BIS_fnc_param;
_weightarr = [_this,1,[],[[]]] call BIS_fnc_param;

CHECK((count _array)!=(count _weightarr))

_weightsum = 0;

For "_i" from 0 to (count _weightarr) do {
	
	If (IS_SCALAR(_weightarr select _i)) then {
		_weightsum = _weightsum + (_weightarr select _i);
	}else{
		_weightarr set[_i,-1];
	};
};

CHECK(_weightsum != 0)

