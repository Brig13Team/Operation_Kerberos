/*
 *  Author: Dorbedo
 *
 *  Description:
 *      displays the clock
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
#include "script_component.hpp"

_this params ["_dialog"];

IF !(dialog) exitWith {
    [GVAR(clockPFH)] call CBA_fnc_removePerFrameHandler;
    GVAR(clockPFH) = nil;
};

If ((isNil "_dialog")&&{isNull _dialog}) exitWith {
    [GVAR(clockPFH)] call CBA_fnc_removePerFrameHandler;
    GVAR(clockPFH) = nil;
};

if !(isNil QGVAR(clockPFH)) then {
    [GVAR(clockPFH)] call CBA_fnc_removePerFrameHandler;
    GVAR(clockPFH) = nil;
};


GVAR(clockPFH) = [
    {
        private _time = format["%1:%2",floor daytime,(daytime mod 1)*60];
        private _control = (findDisplay IDD_TABLET_MAIN) displayCtrl (IDC_TABLET_CLOCK);
        _control ctrlSetText _time;
    },
    1,
    [_dialog]
] call CBA_fnc_addPerFrameHandler;
