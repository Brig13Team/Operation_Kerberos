/*
	Author: Dorbedo

	Description:
		spawns a function where a abject is local
		less network traffic then EventExecLocal

	Parameter(s):
		
		0 : OBJECT
		1 : CODE/STRING
		2 : ANY - Parameter

*/
#include "script_component.hpp"

SCRIPT(EventLocal);
_this params[["_target",objNull,[objNull,grpNull]],["_function","",["",{}]],["_params",[]]];
TRACEV_3(_target,_function,_params);

CHECKRET((isNull _target || _function isEqualTo ""),false);


if (Local _target) exitWith {
	if (IS_STRING(_function)) then {
		_params spawn compile _function;
	}else{
		_params spawn _function;
	};
	true;
};


private "_id";
If (IS_GROUP(_target)) then {
	_id = groupOwner _target;
}else{
	_id = owner _target;
};

GVARMAIN(EVENTLOCAL) = [_target,_function,_params];

If (_id > 0) exitWith {	
	_id publicVariableClient QGVARMAIN(EVENTLOCAL);
	true;
};
publicVariableServer QGVARMAIN(EVENTLOCAL);
true;