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
_this params[["_target",objNull,[objNull,grpNull]],["_function","",["",{}]],["_params",[]]];
TRACEV_3(_target,_function,_params);

CHECKRET((isNull _target || _function isEqualTo ""),false);


if (Local _target) exitWith {
    [_function,_params,_target] call FUNC(_EventExec);
};


private "_id";
If (IS_GROUP(_target)) then {
    _id = groupOwner _target;
}else{
    _id = owner _target;
};

If (_id > 0) exitWith {    
    DOUBLES(PREFIX,e) = [_target,_function,_params];
    _id publicVariableClient QUOTE(DOUBLES(PREFIX,e));
    true;
};
DOUBLES(PREFIX,l) = [_target,_function,_params];
publicVariableServer QUOTE(DOUBLES(PREFIX,l));
true;