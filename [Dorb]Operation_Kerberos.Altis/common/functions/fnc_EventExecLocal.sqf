/*
	Author: Dorbedo

	Description:
		spawns a function if a object is local
		faster then EventLocal, but more networktraffic for all clients

	Parameter(s):
		
		0 : OBJECT
		1 : CODE/STRING
		2 : ANY - Parameter

*/
#include "script_component.hpp"

SCRIPT(EventExecLocal);
_this params[["_target",objNull,[objNull,grpNull]],["_function","",["",{}]],["_params",[]]];
TRACEV_3(_target,_function,_params);

CHECKRET((isNull _target || _function isEqualTo ""),false);


if (Local _target) exitWith {
	if (IS_STRING(_function)) then {
		_params spawn compile _function;
	}else{
		_params spawn _function;
	};
};

GVARMAIN(EVENTEXEC) = [_function,_params,_target];
publicVariableServer QGVARMAIN(EVENTEXEC);
[_function,_params,_target] spawn FUNC(EventExec);
true