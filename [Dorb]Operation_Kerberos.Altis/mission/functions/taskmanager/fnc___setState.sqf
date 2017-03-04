/*
    Author: iJesuz

    Description:
        internal function
        (set mission state)

    Parameter(s):
        0 : HASH    - taskhandler
        1 : HASH    - mission
        2 : STRING  - state

    Return:
        -
*/
#include "script_component.hpp"

_this params["_taskhandler", "_mission", "_state"];

HASH_SET(_mission, "state", _state);

if ((toUpper _state) in ["SUCCEEDED","CANCELED","FAILED"]) then {
    private _name   = HASH_GET(_mission, "name");
    TRACEV_2(_name, _state);
    HASH_SET(_taskhandler, "missions", HASH_GET(_taskhandler, "missions") - [_name]);
    [_mission] call FUNC(taskmanager___cancelAll);

    [QEGVAR(mission,end_server), [_mission]] call CBA_fnc_localEvent;
    // TODO: client event (without mission hash - it's local!)
};

// set state in Bohemia's system
if (not (_state isEqualTo "")) then {
    private _taskID = HASH_GET(_mission, "BIS_taskID");
    [HASH_GET(_mission,"BIS_taskID"),nil,nil,nil,_state,nil,false] call BIS_fnc_setTask;
};
