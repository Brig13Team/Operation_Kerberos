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
SCRIPT(canunload);

if (player getVariable [QGVAR(isloading),false]) exitWith { false };

params[["_target",objNull,[objNull]]];

if (isNull _vehicle) exitWith {};

private["_logistic_stack"];

_logistic_stack = _target getVariable [QGVAR(stack),[]];

(!(_logistic_stack isEqualTo []))