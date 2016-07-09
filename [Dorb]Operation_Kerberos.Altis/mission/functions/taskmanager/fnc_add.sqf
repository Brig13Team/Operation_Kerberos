/*
    Author: iJesuz

    Description:
        Create new Task

    Parameter(s):
        0 : STRING          - ConfigName
        1 : [STRING,ARRAY]  - Destination [Locationname, Position]
        2 : CODE            - Conditional Function


    Return:
        STRING
*/
#include "script_component.hpp"

_this params [["_configName","",[""]], ["_destination",["",[0,0,0]],[["",[]]]], ["_func",{},[{}]]];

GVAR(task_counter) = GVAR(task_counter) + 1;

private _side = GVARMAIN(playerside);
private _type = getText(configFile >> "CfgTaskTypes" >> _configName >> "tasktype" );
private _taskID = format["%1_%2", QGVAR(task),GVAR(task_counter)];

[_taskID, _side, _configName, _destination select 1, "AUTOASSIGNED", 1, false, true, _type, false] call BIS_fnc_setTask;

GVAR(conditions) pushBack [_func,GVAR(task_counter)];

_number
