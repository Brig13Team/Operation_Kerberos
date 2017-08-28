/*
 *  Author: iJesuz, Dorbedo
 *
 *  Description:
 *      the RTB Task
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

_this params ["_mainmission"];

private _TaskID = _mainmission getVariable ["TaskID",str (random 999999)];
_TaskID = format["%1_RTB",_TaskID];

If (_thisTransition == "toRTB") then {
    // the RTB-Task should be created
    [
        _TaskID,
        GVARMAIN(playerside),
        [
            LSTRING(RTB_DESC),
            LSTRING(RTB_TITLE),
            ""
        ],
        getMarkerPos GVARMAIN(respawnmarker),
        "ASSIGNED",
        100,
        false,
        true,
        "run",
        false
    ] call BIS_fnc_setTask;
    [QEGVAR(gui,message),[LSTRING(RTB_TITLE),LSTRING(RTB_DESC),"blue"]] call CBA_fnc_globalEvent;
}else{
    // RTB is Finished
    [
        _TaskID,
        "SUCCEEDED",
        false
    ] call BIS_fnc_taskSetState;
    [QEGVAR(gui,message),[LSTRING(RTB_TITLE),LSTRING(RTB_SUCCESS),"green"]] call CBA_fnc_globalEvent;
};
