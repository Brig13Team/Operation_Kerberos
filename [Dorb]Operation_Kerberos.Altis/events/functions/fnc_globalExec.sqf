/*
    Author: Dorbedo

    Description:
        spawns a function global
        Target can be (-5 == AllPlayer)||(-4 == Headless,Server)||(-3 == Headless)||(-2 == global)||(-1 == AllClients)||(0 == server)
    Parameter(s):
        
        0 : CODE/STRING - code/function to be executed
        (optional)
        1 : ANY - Parameter
        2 : SCALAR - Target
        3 : BOOLEAN - execute on this machine too (default true)
*/
#include "script_component.hpp"
_this params[
    ["_function","",["",{}]],
    ["_parameter",[]],
    ["_target",-2,[0]],
    ["_local",true,[false]]
    ];
_target = switch (_target) do {
    case -5 : {[] call EFUNC(common,players);};
    case -4 : {
            If (!isNil QGVAR(HeadlessClients)) then {
                [2,GVAR(HeadlessClients)];
            }else{
                2;
            };
        };
    case -3 : {
        If (!isNil QGVAR(HeadlessClients)) then {
            GVAR(HeadlessClients);
        }else{
            [];
        };
    };
    case -2 : {0;};
    case -1 : {-2;};
    case 0 : {2;};
    default {0;};
};


[_parameter,_function,_target,_local] call FUNC(remoteExec);