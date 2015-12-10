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
params[["_position",[],[[]],[2,3]],["_radius",600,[0]],["_step",20,[0]]];
CHECKRET((_position isEqualTo []),[]);
CHECKRET(((_step < 1)||(_radius < 5)),[_position]);
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
