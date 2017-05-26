/*
*  Author: iJesuz, Dorbedo
 *
 *  Description:
 *      ends a mission
 *
 *  Parameter(s):
 *      0 : LOCATION - the last MainMission
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_mission"];

private _TaskID = _mission getVariable "taskID";
If (IS_ARRAY(_TaskID)) then {
    _TaskID = _TaskID select 0;
};
private _type = _mission getVariable ["type",""];

If !([_TaskID] call BIS_fnc_taskExists) exitWith {
    /* the task is finihed but not created yet. */
};

private _missionCfg = _mission getVariable "missionCfg";

switch _thisTransition do {
    case "succeeded" : {
        [
            _TaskID,
            "SUCCEEDED",
            false
        ] call BIS_fnc_taskSetState;
        private _title = getText(_missionCfg >> "task" >> "title");
        private _text = getText(_missionCfg >> "task" >> "onSuccess");
        [QEGVAR(gui,message),[[_title,_text],"green"]] call CBA_fnc_globalEvent;
    };
    case "neutral" : {
        [
            _TaskID,
            "CANCELED",
            false
        ] call BIS_fnc_taskSetState;
        private _title = getText(_missionCfg >> "task" >> "title");
        private _text = getText(_missionCfg >> "task" >> "onSuccess");
        [QEGVAR(gui,message),[[_title,_text],"green"]] call CBA_fnc_globalEvent;
    };
    case "timeout";
    case "failed" : {
        [
            _TaskID,
            "FAILED",
            false
        ] call BIS_fnc_taskSetState;
        private _title = getText(_missionCfg >> "task" >> "title");
        private _text = getText(_missionCfg >> "task" >> "onSuccess");
        [QEGVAR(gui,message),[[_title,_text],"green"]] call CBA_fnc_globalEvent;
    };
    default {
        // something happend, the task gets canceled
        [
            _TaskID,
            "CANCELED",
            false
        ] call BIS_fnc_taskSetState;
    };
}
