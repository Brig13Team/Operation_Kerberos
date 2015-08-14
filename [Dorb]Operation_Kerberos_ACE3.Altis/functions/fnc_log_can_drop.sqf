/*
	Author: Dorbedo
	
	Description:
		Checks if Unit can load
		
	Parameter(s):
		0 : OBJECT - Target
		
	Returns:
		BOOL
*/
#include "script_component.hpp"
SCRIPT(log_candrop);
PARAMS_1(_target);
private["_logistic_stack"];

_logistic_stack = _target getVariable ["LOGISTIC_CARGO_STACK",[]];
If ((_logistic_stack isEqualTo [])||(vehicle player != _target)) exitWith {false};

If (!((driver _target)==player)) exitWith {false};

_velocity = velocity _target;

If (((vectorMagnitude _velocity)<100)||((vectorMagnitude _velocity)>250)) exitWith {false};

true

