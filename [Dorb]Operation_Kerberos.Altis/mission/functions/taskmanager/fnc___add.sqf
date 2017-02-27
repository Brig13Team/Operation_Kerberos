/*
    Author: iJesuz

    Description:
        internal function
        (add mission to taskhandler)

    Parameter(s):
        0 : HASH    - taskhandler
        1 : HASH    - mission

    Return:
        -
*/
#include "script_component.hpp"

_this params ["_taskhandler", "_mission"];

// _mission becomes a taskhandler
private _num  = HASH_GET(_taskhandler, "counter") + 1;
private _name = format["%1_%2", HASH_GET(_taskhandler, "name"), _num];
HASH_SET(_mission, "name", _name);
HASH_SET(_mission, "counter", 0);
HASH_SET(_mission, "missions", []);

// add _mission to _taskhandler
HASH_SET(_taskhandler, _name, _mission);
HASH_SET(_taskhandler, "missions", HASH_GET(_taskhandler, "missions") + [_name]);
HASH_SET(_taskhandler, "counter", _num);

// register mission in Bohemia's task system
private _type = HASH_GET(_mission, "type");
private _pos  = HASH_GET(_mission, "location") select 1;

private "_taskID";
if (HASH_HASKEY(_taskhandler, "state")) then { // _taskhandler is a mission too
    _taskID = [_name, HASH_GET(_taskhandler, "name")];
    HASH_SET(_mission, "BIS_taskID", _taskID);
} else {
    _taskID = _name;
    HASH_SET(_mission, "BIS_taskID", _taskID);
};

[QEGVAR(mission,start_server), [_mission]] call CBA_fnc_localEvent;
[_taskID, GVARMAIN(playerside), _type, _pos, "AUTOASSIGNED", 1, false, true, _type, false] call BIS_fnc_setTask;
