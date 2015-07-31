/*
	Author: Dorbedo

	Description:
	returns Array with Positions sourrounding a centerpos

	Parameter(s):
		0 :	ARRAY	- Centerpos
		1 : SCALAR 	- Radius
		2 : SCALAR	- Step
		

	Returns:
	ARRAY : Array with Positions

	
*/
#include "script_component.hpp"
SCRIPT(pos_surrounding);
PARAMS_1(_position);
DEFAULT_PARAM(1,_radius,600);
DEFAULT_PARAM(2,_step,20);

CHECK(!(IS_ARRAY(_position)))
CHECK(_position isEqualTo [])
CHECK(_step < 1)
CHECK(_radius < 5)
Private["_searchposarray","_searchrad","_s","_umfang","_theta"];
_searchposarray = [_position];
_searchrad = 1;
_s = 0;
while {_searchrad < _radius} do {
	_umfang = 2 * pi * _searchrad;
	_theta = ((_s*360)/(2*_searchrad*pi));
	_searchposarray pushBack ([_position, _searchrad, _theta] call BIS_fnc_relPos);
	_s=_s+_step;
	If (_s > _umfang) then {
		_searchrad = _searchrad + _step;
		_s=0;
	};
};

_searchposarray
