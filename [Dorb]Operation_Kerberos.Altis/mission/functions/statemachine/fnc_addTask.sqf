/*
*  Author: iJesuz, Dorbedo
 *
 *  Description:
 *      adds the task
 *
 *  Parameter(s):
 *      0 : LOCATION - the mainmission
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_mission"];

private _objects = _mission getVariable ["objects",[]];
private _showMarker = _mission getVariable ["showmarker",true];
private _markerpos = (_mission getVariable ["location",[[]]]) select 1;
private _type = _mission getVariable ["type",""];
private _isMain = _mission getVariable ["isMain",true];
private _missioncfg = _mission getVariable "missioncfg";

private _timeOut = getNumber(_missionCfg >> "condition" >> "timeout");
If (_timeOut > 0) then {
    _mission setVariable ["timeout",CBA_missiontime + _timeout];
};

TRACEV_5(_objects,_showMarker,_markerpos._type,_isMain);
If (_isMain) then {
    // share the main objects for triangulation
    GVAR(targets_client) = _objects;
    publicVariable QGVAR(targets_client);

    // mission start event
    [QEGVAR(mission,start_server), [_mission]] call CBA_fnc_localEvent;
};

private _taskID = _mission getVariable "taskID";
private _showMarker = _mission getVariable ["showMarker",true];
private _markerpos = _mission getVariable "centerpos";
TRACEV_3(_missionCfg,_taskID,_showMarker);

private _taskdelay = (_mission getVariable ["taskdelay",0])+5;
TRACEV_6(_taskdelay,_mission,_taskID,_type,_showmarker,_markerpos);
[
    {
        _this params ["_mission","_taskID","_missionCfg","_showmarker","_markerpos"];
        // if the task has already finished
        private _progress = switch (_mission getVariable ["progress","none"]) do {
            case "succeeded" : {"SUCCEEDED"};
            case "failed" : {"FAILED"};
            case "cancel";
            case "neutral" : {"CANCELED"};
            default {"CREATED"};
        };
        private _tasktype = getText(_missionCfg >> "task" >> "tasktype");
        private _description = getText(_missionCfg >> "task" >> "description");
        private _title = getText(_missionCfg >> "task" >> "title");
        TRACEV_4(_progress,_tasktype,_description,_title);
        [
            _taskID,
            GVARMAIN(playerside),
            [
                _description,
                _title,
                ""
            ],
            if ((_showMarker)&&{!isNil "_markerpos"}) then {_markerpos}else{nil},
            _progress,
            2,
            false,
            true,
            _tasktype,
            false
        ] call BIS_fnc_setTask;
    },
    [_mission,_taskID,_missionCfg,_showmarker,_markerpos],
    _taskdelay
] call CBA_fnc_waitandExecute;


private _conditiontype = _mission getVariable ["conditiontype",""];
_mission setVariable ["conditiontype",_conditiontype];
