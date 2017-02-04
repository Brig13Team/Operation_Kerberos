/*
    Author: iJesuz

    Description:
        create new task

    Parameter(s):
        0 : STRING          - ConfigName
        1 : [STRING,ARRAY]  - Destination [Locationname, Position]
        2 : CODE            - (optional) code to be executed before mission is spawned
        3 : CODE            - (optional) code to be executed after mission is spawned

    Return:
        STRING
*/
#include "script_component.hpp"

_this params [["_configName", "", [""]], ["_destination", ["",[0,0,0]], [["",[]]]], ["_preFnc", {}, [{}]], ["_postFnc", {}, [{}]]];

// get settings
private _num  = THIS_GET("task_counter") + 1;
private _side = GVARMAIN(playerside);
private _type = getText(missionConfigFile >> "CfgTaskDescriptions" >> _configName >> "tasktype");
private _taskID = format["%1_%2", QGVAR(task), _num];
THIS_SET("task_counter", _num);

// spawn task objects
// TOOD: move parts from here into spawn !!
[_configName, _destination] call _preFnc;
private _ret = _destination call (missionNamespace getVariable [format["dorb_mission_fnc_mainmission_%1", _configName], {}]);
private _func = _ret select 0;
private _args = _ret select 1;
[_configName, _destination] call _preFnc;

// create task
[_taskID, _side, _configName, _destination select 1, "AUTOASSIGNED", 1, false, true, _type, false] call BIS_fnc_setTask;

// save task
private _missionHash = HASH_CREATE;
THIS_SET(_taskID, _missionHash);
HASH_SET(_missionHash, "condition_fnc", _func);
HASH_SET(_missionHash, "condition_arg", _args);
HASH_SET(_missionHash, "sidemissions",  []);

[QEGVAR(mission,start),[_nextLocation select 1,_nextMission]] call CBA_fnc_localEvent;

_taskID
