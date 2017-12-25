#include "script_component.hpp"
/**
 * Name: dorb_mission_fnc_statemachine_addTask
 *
 * Author: Dorbedo
 * adds the task
 *
 * Arguments:
 * 0: <LOCATION> the mission
 *
 * Return Value:
 * Nothing
 *
 */

params ["_mission"];

private _objects = _mission getVariable ["objects", []];
private _showMarker = _mission getVariable ["showmarker", true];
private _markerpos = (_mission getVariable ["location", [[]]]) select 1;
private _type = _mission getVariable ["type", ""];
private _missioncfg = _mission getVariable "missioncfg";

private _timeOut = getNumber(_missionCfg >> "condition" >> "timeout");
If (_timeOut > 0) then {
    _mission setVariable ["timeout",CBA_missiontime + _timeout];
};

[_objects] call FUNC(statemachine_broadcastMissionTargets);
[QEGVAR(mission,start_server), [_mission]] call CBA_fnc_localEvent;


private _taskID = _mission getVariable "taskID";
private _showMarker = _mission getVariable ["showMarker", true];
private _markerpos = _mission getVariable "centerpos";

private _taskdelay = (_mission getVariable ["taskdelay", 0])+5;

[
    {
        params ["_mission","_taskID","_missionCfg","_showmarker","_markerpos"];
        // if the task has already finished
        private _progress = switch (_mission getVariable ["progress","none"]) do {
            case "succeeded" : {"SUCCEEDED"};
            case "failed" : {"FAILED"};
            case "cancel";
            case "neutral" : {"CANCELED"};
            default {"CREATED"};
        };
        {
            private _taskside = "task" + str _x;
            private _tasktype = getText(_missionCfg >> _taskside >> "tasktype");
            private _description = getText(_missionCfg >> _taskside >> "description");
            private _title = getText(_missionCfg >> _taskside >> "title");
            private _taskIDSide = format["%1_%2", _taskID, _x];
            [
                _taskIDSide,
                _x,
                [
                    _description,
                    _title,
                    ""
                ],
                if ((_showMarker) && {!isNil "_markerpos"}) then {_markerpos} else {nil},
                _progress,
                2,
                false,
                true,
                _tasktype,
                false
            ] call BIS_fnc_setTask;
        } count [west, east, independent, civilian];
    },
    [_mission, _taskID, _missionCfg, _showmarker, _markerpos],
    _taskdelay
] call CBA_fnc_waitandExecute;

private _conditiontype = _mission getVariable ["conditiontype", ""];
_mission setVariable ["conditiontype", _conditiontype];
