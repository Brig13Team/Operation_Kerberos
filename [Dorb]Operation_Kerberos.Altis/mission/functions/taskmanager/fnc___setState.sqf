/*
    Author: iJesuz

    Description:
        internal function
        (set mission state)

    Parameter(s):
        0 : HASH    - taskhandler
        1 : STRING  - mission name
        2 : STRING  - state

    Return:
        -
*/
#include "script_component.hpp"

_this params["_taskhandler", "_name", "_state"];

private _mission = HASH_GET(_taskhandler,_name);
HASH_SET(_mission, "state", _state);

if ((toUpper _state) in ["SUCCEEDED","CANCELED","FAILED"]) then {
    HASH_SET(_taskhandler, "missions", HASH_GET(_taskhandler, "mission") - [_name]);
    [_mission] call FUNC(taskhandler___cancelAll);
};

// set state in Bohemia's system
[HASH_GET(_mission,"BIS_taskID"),nil,nil,nil,_state,nil,false] call BIS_fnc_setTask;
