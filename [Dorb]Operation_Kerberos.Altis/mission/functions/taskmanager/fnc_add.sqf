/*
    Author: iJesuz

    Description:
        Create new Task

    Parameter(s):
        0 : STRING          - ConfigName
        1 : [STRING,ARRAY]  - Destination [Locationname, Position]

    Return:
        NUMBER
*/
#include "script_component.hpp"

_this params [["_configName","",[""]], ["_destination",["",[0,0,0]],[["",[]]]]];

GVAR(task_counter) = GVAR(task_counter) + 1;

private _side = GVARMAIN(playerside);
private _type = getText(missionConfigFile >> "CfgTaskDescriptions" >> _configName >> "tasktype");
private _taskID = format["%1_%2", QGVAR(task),GVAR(task_counter)];

// Spawn Task Objects
private _ret = [_destination] call (missionNamespace getVariable [format ["dorb_mission_fnc_mainmission_%1",_configName],{}]);
private _func = _ret select 0;
private _args = _ret select 1;

// Create Task
[_taskID, _side, _configName, _destination select 1, "AUTOASSIGNED", 1, false, true, _type, false] call BIS_fnc_setTask;

GVAR(conditions) pushBack [_func, _args, GVAR(task_counter)];

GVAR(task_counter)
