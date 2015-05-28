/*
	Author: Dorbedo
	
	Description:
		calls a function on an specific Client
		
	Call via:
		[target,function,[parameters]] FCALL(local)
*/
#include "makros.hpp"

_target = _this select 0;
_function = _this select 1;
_parameters = [_this,2,[],[[]]] call BIS_fnc_param;

if (local _target) exitwith {_parameters FCALL(_function)};
[-2,{_this FCALL(local_check)},[_function,_parameters]] FMP;