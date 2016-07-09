/*
    Author: iJesuz

    Description:
        Deletes a Task

    Parameter(s):
        0 : NUMBER  - TaskNumber

    Return:
		-

*/
#include "script_component.hpp"

_this params [["_number",-1,[0]]];

if ([_number] call EFUNC(taskmanager,exists)) then {
    [format["%1_%2",QGVAR(task),_number]] call BIS_fnc_deleteTask;
    true
} else {
    false
}
