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
    {
        [
            _x select 0,
            _x select 1,
            [LSTRING(RTB_DESC), LSTRING(RTB_TITLE), ""],
            _x select 2,
            "ASSIGNED",
            100,
            false,
            true,
            "run",
            false
        ] call BIS_fnc_setTask;
    } forEach [
        [_TaskID + "_west", west, getMarkerPos "respawn_west"],
        [_TaskID + "_east", east, getMarkerPos "respawn_east"],
        [_TaskID + "_independent", independent, getMarkerPos "respawn_guerrila"],
        [_TaskID + "_civilian", civilian, getMarkerPos "respawn_civilian"]
    ];
    [QEGVAR(gui,message),[LSTRING(RTB_TITLE),LSTRING(RTB_DESC),"blue"]] call CBA_fnc_globalEvent;
}else{
    // RTB is Finished
    {
        [
            _x,
            "SUCCEEDED",
            false
        ] call BIS_fnc_taskSetState;
    } forEach [
        _TaskID + "_west",
        _TaskID + "_east",
        _TaskID + "_independent",
        _TaskID + "_civilian"
    ];
    [QEGVAR(gui,message),[LSTRING(RTB_TITLE),LSTRING(RTB_SUCCESS),"green"]] call CBA_fnc_globalEvent;
};
