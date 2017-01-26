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
TRACEV_5(_configName,_destination,_side,_type,_taskID);
// Spawn Task Objects
private _ret = _destination call (missionNamespace getVariable [format ["dorb_mission_fnc_mainmission_%1",_configName],{}]);
private _funcName = format [ARR_2("dorb_mission_fnc_mainmission_%1",_configName)];
private _funcAvailible = isNil (missionNamespace getVariable _funcName);
TRACEV_3(_funcName,_funcAvailible,_destination);
private _func = _ret select 0;
private _args = _ret select 1;
TRACEV_3(_ret,_func,_args);
// Create Task
[_taskID, _side, _configName, _destination select 1, "AUTOASSIGNED", 1, false, true, _type, false] call BIS_fnc_setTask;

//GVAR(conditions) pushBack [_func, _args, GVAR(task_counter)];

GVAR(task_counter)
