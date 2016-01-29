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
_this params[["_target",objNull,[objNull,grpNull]],["_function","",["",{}]],["_params",[]]];
TRACEV_3(_target,_function,_params);

CHECKRET((isNull _target || _function isEqualTo ""),false);

if (Local _target) exitWith {
    [_function,_params,_target] call FUNC(_EventExec);
};

DOUBLES(PREFIX,e) = [_function,_params,_target];
publicVariableServer QUOTE(DOUBLES(PREFIX,e));
true;