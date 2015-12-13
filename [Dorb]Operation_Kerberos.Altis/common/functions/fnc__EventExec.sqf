/*
    Author: Dorbedo

    Description:
        INTERNAL
        spawns a event
        Target can be the owner of an object/group or (-5 == AllPlayer)||(-4 == Headless,Server)||(-3 == Headless)||(-2 == global)||(-1 == AllClients)||(0 == server)

    Parameter(s):
        
        0 : CODE/STRING
        (optional)
        1 : ANY - Parameter
        2 : OBJECT/GROUP/SCALAR - Target

*/
#include "script_component.hpp"

SCRIPT(_EventExec);
If (_this params[["_function","",["",{}]],["_params",[]],["_target",objNull,[objNull,grpNull,0]]]) exitWith {
    TRACEV_3(_function,_params,_target);
    if (IS_STRING(_function)) then {
        _params spawn compile _function;
    }else{
        _params spawn _function;
    };
};
TRACEV_3(_function,_params,_target);

If (IS_SCALAR(_target)) exitWith {
    private "_exec";
    If ({ switch _target do {
            case 0 : {If (isServer) then {true}else{false};};
            case -1 : {If (!isServer) then {true}else{false};};
            case -3 : {If (!isServer&&!hasInterface) then {true}else{false};};
            case -4 : {If (!hasInterface) then {true}else{false};};
            case -5 : {If (hasInterface) then {true}else{false};};
            default {true};
        }}) then {
        if (IS_STRING(_function)) then {
            _params spawn compile _function;
        }else{
            _params spawn _function;
        };    
    };
};


CHECK(!(local _target))

if (IS_STRING(_function)) then {
    _params spawn compile _function;
}else{
    _params spawn _function;
};