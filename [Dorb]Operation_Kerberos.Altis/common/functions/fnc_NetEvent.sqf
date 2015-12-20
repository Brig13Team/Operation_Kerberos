/*
    Author: Dorbedo

    Description:
        spawns a function global
        Target can be (-5 == AllPlayer)||(-4 == Headless,Server)||(-3 == Headless)||(-2 == global)||(-1 == AllClients)||(0 == server)
    Parameter(s):
        
        0 : CODE/STRING
        (optional)
        1 : ANY - Parameter
        2 : SCALAR - Target
        3 : BOOLEAN - execute on this machine too (default true)
*/
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(NetEvent);
TRACEV_1(_this);
_this params[
	["_function","",["",{}]],
	["_parameter",[]],
	["_target",-2,[0]],
	["_local",true,[false]]
	];
TRACEV_2(_function,_parameter,_target);

CHECKRET((_function isEqualTo ""),false);

DOUBLES(PREFIX,e) = [_function,_parameter,_target];
If (isServer) then {
    publicVariable QUOTE(DOUBLES(PREFIX,e));
}else{
    publicVariableServer QUOTE(DOUBLES(PREFIX,e));
};
If (_local) then {
    DOUBLES(PREFIX,e) call FUNC(_EventExec);
};
true;