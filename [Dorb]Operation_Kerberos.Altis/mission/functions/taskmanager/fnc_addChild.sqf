/*
    Author: iJesuz

    Description:
        Create new Child Task

    Parameter(s):
        0 : STRING          - ConfigName
        1 : NUMBER          - Parent TaskNumber
        2 : [STRING,ARRAY]  - Destination [Locationname, Position]
        3 : CODE            - Conditional Function

    Return:
        [NUMBER,NUMBER]
*/
#include "script_component.hpp"

_this params [
    ["_configName","",[""]],
    ["_parent",-1,[0]],
    ["_destination",["",[0,0,0]],[[]],
    ["_func",{},[{}]],
    "_args"
];

private _children = missionNamespace getVariable [format["@%1_%2.2",QGVAR(task),_parent],[]];
private _number = (count _children) + 1;

private _side = GVARMAIN(playerside);
private _type = getText(missionConfigFile >> "CfgTaskDescriptions" >> _configName >> "tasktype");
private _taskID  = format["%1_%2_side_%3", QGVAR(task), _parent, _number];
private _pTaskID = format["%1_%2", QGVAR(task), _parent];

[[_taskID,_pTaskID], _side, _configName, _destination select 1, "AUTOASSIGNED", 1, false, true, _type, false] call BIS_fnc_setTask;

GVAR(conditions) pushBack [_func,_args,[_parent,_number]];

_number






/*
_this params [["_configName","",[""]], ["_parent",-1,[0]], ["_destination",["",[0,0,0]],[["",[]]]], ["_func",{},[{}]]];

private _children = missionNamespace getVariable [format["@%1_%2.2",QGVAR(task),_parent],[]];
private _number = (count _children) + 1;

private _side = GVARMAIN(playerside);
private _type = getText(missionConfigFile >> "CfgTaskDescriptions" >> _configName >> "tasktype");
private _taskID  = format["%1_%2_side_%3", QGVAR(task), _parent, _number];
private _pTaskID = format["%1_%2", QGVAR(task), _parent];

[[_taskID,_pTaskID], _side, _configName, _destination select 1, "AUTOASSIGNED", 1, false, true, _type, false] call BIS_fnc_setTask;

GVAR(conditions) pushBack [_func,[_parent,_number]];

_number
*/
