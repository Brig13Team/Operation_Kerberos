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

private _side = GVARMAIN(playerside);
// private _name = getText(configFile >> "CfgTaskDescription" >> _configName >> "name");
// private _description = getText(configFile >> "CfgTaskDescription" >> _configName >> "description");
// private _marker = getText(configFile >> "CfgTaskDescription" >> _configName >> "marker");
private _type = getText(configFile >> "CfgTaskTypes" >> _configName >> "tasktype" );

private _taskID = format["%1_%2", QGVAR(task),GVAR(task_counter) + 1];
GVAR(task_counter) = GVAR(task_counter) + 1;

[_taskID, _side, /*[_description, _name, _marker]*/ _configName, _destination select 1, "AUTOASSIGNED", 1, false, true, _type, false] call BIS_fnc_setTask;

GVAR(conditions) pushBack [_func,_taskID];

_number
