/**
 * Author: Dobedo
 * sets the timer globally
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

If !(isServer) exitWith {
    [QGVAR(setTimerServer),_this] call CBA_fnc_serverEvent;
};

params [["_timer",-1,[0]],["_code",{},["",{}]],["_parameter",[],[[]]]];

GVAR(timer_finish) = CBA_missiontime + _timer;
GVAR(timer_code) = _code;
GVAR(timer_parameter) = _parameter;

publicVariable QGVAR(timer_finish);
