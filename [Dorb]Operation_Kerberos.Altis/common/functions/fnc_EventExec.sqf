/*
    Author: Dorbedo

    Description:
        spawns a event
        Target can be an object/group or (-2 == global)||(-1 == AllClients)||(0 == server)||(1 == Headless)||(2 == Headless,Server)||(3 == AllPlayer)

    Parameter(s):
        
        0 : CODE/STRING
        (optional)
        1 : ANY - Parameter
        2 : OBJECT/GROUP/SCALAR - Target

*/
#include "script_component.hpp"

SCRIPT(EventExec);
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
            case -1 : {If (!isServer) then {true}else{false};};
            case 0 : {If (isServer) then {true}else{false};};
            case 1 : {If (!isServer&&!hasInterface) then {true}else{false};};
            case 2 : {If (!hasInterface) then {true}else{false};};
            case 3 : {If (hasInterface) then {true}else{false};};
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