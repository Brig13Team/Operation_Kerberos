/*
	Author: Dorbedo

	Description:
		spawns a function global

	Parameter(s):
		
		0 : CODE/STRING
		(optional)
		1 : ANY - Parameter
		2 : SCALAR - (-2 == global)||(-1 == AllClients)||(0 == server)||(1 == Headless)||(2 == Headless,Server)||(3 == AllPlayer)

*/
#include "script_component.hpp"

SCRIPT(EventLocal);
_this params[["_function","",["",{}]],["_params",[]],["_target",0,[0]]];
TRACEV_2(_function,_params,_target);

if (_function isEqualTo "") exitWith {};

GVARMAIN(EVENTEXEC) = [_function,_params,_target];
publicVariableServer QGVARMAIN(EVENTLOCAL);
