/*
    Author: Dorbedo

    Description:
        returns, if a Task is a sideMission

    Parameter(s):
        0 : STRING/SCALAR - ID of the task

    Return
        none
*/
#include "script_component.hpp"
_this params[["_task","",[0,""]]];
CHECKRET(_task isEqualTo "",false);
If (IS_SCALAR(_task)) then {_task = format["TTT%1",_task]};

If ([GVAR(allTasks),_task] call CBA_fnc_hashHasKey) exitWith {true};

private _namearray = _task splitString "_";

If ((count _namearray)>1) exitWith {
    private _value = [GVAR(allTasks),(_namearray select 0)] call CBA_fnc_hashGet;
    (_task in _value);
};
false;