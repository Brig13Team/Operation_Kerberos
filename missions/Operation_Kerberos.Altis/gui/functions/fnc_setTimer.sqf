/**
 * Author: Dobedo
 * sets the timer locally
 *
 * Arguments:
 * 0: <SCALAR> timer
 * 1: <CODE/STRING> code/eventname to be executed on finish
 * 2: <ARRAY> parameter
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

params [["_timer",-1,[0]],["_code",{},["",{}]],["_parameter",[],[[]]]];

GVAR(timer_finish) = CBA_missiontime + _timer;
GVAR(timer_code) = _code;
GVAR(timer_parameter) = _parameter;
