/*
	Author: Dorbedo
	
	Description:
		calls a function on an specific Client
		
	Call via:
		[target,function,[parameters]] call FM(local)
*/
#include "script_component.hpp"
SCRIPT(local);
params["_target","_function",["_parameters",[],[[]]]];

if (local _target) exitwith {_parameters call FM(_function)};
[-2,{_this call FM(local_check)},[_function,_parameters]] FMP;