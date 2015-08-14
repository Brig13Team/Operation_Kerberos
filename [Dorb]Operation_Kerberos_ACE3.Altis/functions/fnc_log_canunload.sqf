/*
	Author: Dorbedo
	
	Description:
		Checks if Unit can unload
		
	Parameter(s):
		0 : OBJECT - Target
		
	Returns:
		BOOL
*/
#include "script_component.hpp"
SCRIPT(log_canunload);
PARAMS_1(_target);
private["_logistic_stack"];

_logistic_stack = _target getVariable ["LOGISTIC_CARGO_STACK",[]];

(!(_logistic_stack isEqualTo []))