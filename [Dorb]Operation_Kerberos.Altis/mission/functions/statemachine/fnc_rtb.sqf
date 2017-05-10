/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the RTB-Mission
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

/*
    //   _stateMachine   - the state machine
    //   _this           - the current list item
    //   _thisTransition - the current transition we're in
    //   _thisOrigin     - the state we're coming from
    //   _thisState      - same as _thisOrigin
    //   _thisTarget     - the state we're transitioning to
*/

_this params ["_mainmission"];

private _TaskID = _mainmission getVariable ["TaskID",str (random 999999)];
_TaskID = format["%1_RTB",_TaskID];

If (_thisTransition == "toRTB") then {
    // the RTB-Task should be created
    [
        GVARMAIN(playerside),
        _TaskID,
        "rtb",
        getMarkerPos GVARMAIN(respawnmarker),
        true,
        100,
        false,
        "run"
    ] call BIS_fnc_taskCreate;
    [QEGVAR(gui,message),[LSTRING(RTB_TITLE),LSTRING(RTB_DESC),"blue"]] call CBA_fnc_globalEvent;
}else{
    // RTB is Finished
    [
        _TaskID,
        "SUCCESS",
        false
    ] call BIS_fnc_taskSetState;
    [QEGVAR(gui,message),[LSTRING(RTB_TITLE),LSTRING(RTB_SUCCESS),"green"]] call CBA_fnc_globalEvent;
};
