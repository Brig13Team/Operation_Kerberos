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
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_mission"];

private _objects = _mission getVariable ["objects",[]];
private _showMarker = _mission getVariable ["showmarker",true];
private _markerpos = (_mission getVariable ["location",[[]]]) select 1;
private _type = _mission getVariable ["type",""];
private _isMain = _mission getVariable ["isMain",true];

If (_isMain) then {
    private _missionCfg = (missionconfigfile >> "mission" >> "main" >> _type);
    If (isNumber(_missionCfg >> "timeout")) then {
        private _timeout = getNumber(_missionCfg >> "timeout");
        _mission setVariable ["timeout",CBA_missiontime + _timeout];
    };

    // share the main objects for triangulation
    GVAR(targets_client) = _objects;
    publicVariable QGVAR(targets_client);

    // mission start event
    [QEGVAR(mission,start_server), [_mission]] call CBA_fnc_localEvent;

}else{
    private _missionCfg = (missionconfigfile >> "mission" >> "side" >> _type);
    If (isNumber(_missionCfg >> "timeout")) then {
        private _timeout = getNumber(_missionCfg >> "timeout");
        _mission setVariable ["timeout",CBA_missiontime + _timeout];
    };
};


private _taskID = _mission getVariable "taskID";
private _showMarker = _mission getVariable ["showMarker",true];
private _markerpos = (_mission getVariable "location")select 1;
TRACEV_3(_type,_taskID,_showMarker);

private _taskdelay = _mission getVariable ["taskdelay",0];

[
    {
        _this params ["_mission","_taskID","_type","_showmarker","_markerpos"];
        // if the task has already finished
        private _progress = switch (_mission getVariable ["progress","none"]) do {
            case "succeeded" : {"SUCCEEDED"};
            case "failed" : {"FAILED"};
            case "cancel";
            case "neutral" : {"CANCELED"};
            default {"CREATED"};
        };
        private _tasktype = getText(missionConfigFile >> "CfgTaskDescriptions" >> _type >> "tasktype");
        [
            _taskID,
            GVARMAIN(playerside),
            _type,
            if ((_showMarker)&&{!isNil "_markerpos"}) then {_markerpos}else{nil},
            _progress,
            2,
            false,
            true,
            _tasktype,
            false
        ] call BIS_fnc_setTask;
    },
    [_mission,_taskID,_type,_showmarker,_markerpos],
    (CBA_missiontime + _taskdelay)
] call CBA_fnc_waitandExecute;


private _conditiontype = _mission getVariable ["conditiontype",""];
_mission setVariable ["conditiontype",_conditiontype];
