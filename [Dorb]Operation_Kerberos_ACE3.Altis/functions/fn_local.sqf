/*
	Author: Dorbedo
	
	Description:
		calls a function on an specific Client
		
	Call via:
		[target,function,[parameters]] call FM(local)
*/
#include "makros.hpp"
PARAMS_2(_target,_function);
_parameters = [_this,2,[],[[]]] call BIS_fnc_param;

if (local _target) exitwith {_parameters call FM(_function)};
[-2,{_this call FM(local_check)},[_function,_parameters]] FMP;