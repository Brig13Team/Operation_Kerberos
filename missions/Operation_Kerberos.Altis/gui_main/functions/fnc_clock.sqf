/**
 * Author: Dorbedo
 * creates the clock PFH
 *
 * Arguments:
 * 0: <DIALOG> the dialog
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

disableSerialization;
params ["_dialog"];

private _clockPFH = _dialog getVariable QGVAR(clockPFH);

If !(isNil "_clockPFH") then {
    [_clockPFH] call CBA_fnc_removePerFrameHandler;
    _dialog setVariable [QGVAR(clockPFH), nil];
};

_dialog setVariable [
    QGVAR(clockPFH),
    [
        LINKFUNC(clockPFH),
        1,
        _dialog
    ] call CBA_fnc_addPerFrameHandler
];
