/*
    Author: Dorbedo

    Description:
        registers a Task

    Parameter(s):
        0 : STRING/SCALAR - ID of the task

    Return
        none
*/
#include "script_component.hpp"
_this params[["_task","",[0,""]]];
CHECK(_task isEqualTo "")

If (isNil QGVAR(allTasks)) then {GVAR(allTasks) = [[],[]] call CBA_fnc_hashCreate;};
If (IS_SCALAR(_task)) then {_task = format["TTT%1",_task]};

private _namearray = _task splitString "_";
private _value = [];
private _searchkey = _task;

If ((count _namearray)>1) exitWith {
    _value = [QGVAR(allTasks),(_namearray select 0)] call CBA_fnc_hashGet;
    _value pushBack _task;
    [QGVAR(allTasks),(_namearray select 0),_value] call CBA_fnc_hashSet;
};
[QGVAR(allTasks),_task,[]] call CBA_fnc_hashSet;