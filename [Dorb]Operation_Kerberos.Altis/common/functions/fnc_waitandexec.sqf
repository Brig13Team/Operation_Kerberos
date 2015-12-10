/*
	Author: Dorbedo
	
	Description:
		waits and executes code
	Parameter(s):
		0: CODE/STRING	- the code to be execued
		1: ARRAY			- parameters
		2: SCALAR		- delay
		
	Return:
		none
*/
#include "script_component.hpp"
SCRIPT(waitAndExec);
_this params [["_code","",[{},""]],["_parameter",[],[[]]],["_delay",1,[0]]];
TRACEV_3(_code,_parameter,_delay);
CHECKRET((_code isEqualTo ""),false);

If (IS_STRING(_code)) then {
	_code = compile _code;
};

GVAR(waitAndExecArray) pushBack [(diag_ticktime + _delay), _code, _parameter];
GVAR(waitAndExecArray) sort true;
true;