/*
 *  Author: Dorbedo
 *
 *  Description:
 *      set the timer
 *
 *  Parameter(s):
 *      0 : SCALAR - timer
 *      1 : CODE - code to be executed on finish
 *      2 : ARRAY - parameter
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_timer",-1,[0]],["_code",{},["",{}]],["_parameter",[],[[]]]];

GVAR(timer_finish) = CBA_missiontime + _timer;
GVAR(timer_code) = _code;
GVAR(timer_parameter) = _parameter;

If (isNil QGVAR(timer_handle)) then {
    GVAR(timer_handle) = [LINKFUNC(handleTimer),10,[]] call CBA_fnc_addPerFrameHandler;
};
