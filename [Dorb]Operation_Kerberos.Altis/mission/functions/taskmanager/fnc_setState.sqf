/*
    Author: iJesuz

    Description:
        set task state

    Parameter(s):
        0 : STRING  - TaskID
        1 : STRING  - state

    Return:
        -

*/
#include "script_component.hpp"

_this params [["_name", "", ["",[]]], ["_state", "Assigned", [""]]];

if (THIS_HASKEY(_name)) then {
    if ((toUpper _state) in ["SUCCEEDED","CANCELED","FAILED"]) then {
        private _mission = THIS_GET(_name);
        THIS_SET("missions", THIS_GET("missions") - [_name]);

        {
            [[_x, _name], "Canceled"] call FUNC(taskmanager_setStateChild);
        } forEach HASH_GET(_mission, "sidemissions");

        THIS_REM(_x);
    };

    [_name,nil,nil,nil,_state,nil,false] call BIS_fnc_setTask;
};
