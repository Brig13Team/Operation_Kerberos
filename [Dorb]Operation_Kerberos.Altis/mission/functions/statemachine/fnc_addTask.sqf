/*
*  Author: iJesuz, Dorbedo
 *
 *  Description:
 *      adds the task (visible message)
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

/*
    //   _stateMachine   - the state machine
    //   _this           - the current list item
    //   _thisTransition - the current transition we're in
    //   _thisOrigin     - the state we're coming from
    //   _thisState      - same as _thisOrigin
    //   _thisTarget     - the state we're transitioning to
*/

_this params ["_mission"];

private _objects = _mission getVariable ["objects",[]];
private _showMarker = _mission getVariable ["showmarker",true,[true]];
private _markerpos = (_mission getVariable ["location",[[]]]) select 1;

private _missionCfg = (missionconfigfile >> "");














//

If (isNumber(_missionCfg >> "timeout")) then {
    private _timeout = getNumber(_missionCfg >> "timeout");
    _mission setVariable ["timeout",CBA_missiontime + _timeout];
};

_mission setVariable ["conditiontype",_conditiontype];

//
