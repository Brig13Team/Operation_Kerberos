/*
    Author: Dorbedo

    Description:
        spawns a function global
        Target can be (-5 == AllPlayer)||(-4 == Headless,Server)||(-3 == Headless)||(-2 == global)||(-1 == AllClients)||(0 == server)
    Parameter(s):
        
        0 : STRING/CODE - code/function to be executed
        (optional)
        1 : ANY - Parameter
        2 : 
            ARRAY - combination of the following types
            SCALAR - TargetID
            SIDE - All players of the side
            OBJECT - executed by the owner
            GROUP - the function will be executed only on client who is member of the group
            BOOL - True for everywhere (default), false for Server
        3 : BOOL - execute on this machine too (default true)
        4 : BOOL - true= call ; false = spawn (default)
        5 : BOOL - isPersistent
*/
#include "script_component.hpp"
_this params[
    ["_parameter",[]],
    ["_function","",[""]],
    ["_target",true,[[],0,west,objNull,grpNull,true]],
    ["_local",true,[false]],
    ["_call",false,[false]],
    ["_isPersistent",false,[false]]
    ];
    
If (_target isEqualType []) exitWith {
    If (true in _target) then {
        _local = false;
        [_parameter,_function,true,_local,_call] call FUNC(remoteExec);
    }else{
        {
            [_parameter,_function,_x,_local,_call] call FUNC(remoteExec);
        }forEach _target;
    };
};

If (_local) then {
    _parameter spawn (missionNamespace getVariable [_function,{true}]);
    _local = false;
};

If (_target isEqualType true) then {_target = [2,0] select _target;};

If (_call) then {
    _parameter remoteExecCall [_function,_target,_isPersistent];
}else{
    _parameter remoteExec [_function,_target,_isPersistent];
};