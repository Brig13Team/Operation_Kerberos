/**
 * Author: Dorbedo
 * onUnload Event
 *
 * Arguments:
 * 0: <DISPLAY> the display to be unloaded
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

disableSerialization;
params ["_dialog"];

private _clock = _dialog getVariable QGVAR(clockPFH);

if !(isNil "_clock") then {
    [_clock] call CBA_fnc_removePerFrameHandler;
    _dialog setVariable [QGVAR(clockPFH), nil];
};

[] call FUNC(closeMetro);
