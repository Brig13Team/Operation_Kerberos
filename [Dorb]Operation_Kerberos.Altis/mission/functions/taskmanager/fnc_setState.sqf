/*
    Author: iJesuz

    Description:
        Deletes a Task

    Parameter(s):
        0 : NUMBER  - TaskNumber
        1 : STRING	- State

    Return:
    	-

*/
#include "script_component.hpp"

_this params [["_number",-1,[0]],["_state","ASSIGNED",[""]]];

private _taskID = format ["%1_%2",QGVAR(task),_number];

[_taskID,nil,nil,nil,_state,nil,false] call BIS_fnc_setTask;
