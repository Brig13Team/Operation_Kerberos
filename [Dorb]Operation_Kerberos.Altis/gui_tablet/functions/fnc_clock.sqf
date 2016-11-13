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

disableSerialization;
_this params ["_dialog"];

If !(canSuspend) exitWith {[_dialog] spawn FUNC(clock);};

IF !(dialog) exitWith {
    If (!isNil QGVAR(clockPFH)) then {
        [GVAR(clockPFH)] call CBA_fnc_removePerFrameHandler;
    };
    LOG("no Dialog opened");
    GVAR(clockPFH) = nil;
};

If ((isNil "_dialog")&&{isNull _dialog}) exitWith {
    If (!isNil QGVAR(clockPFH)) then {
        [GVAR(clockPFH)] call CBA_fnc_removePerFrameHandler;
    };
    LOG("no Dialog given");
    GVAR(clockPFH) = nil;
};

if !(isNil QGVAR(clockPFH)) then {
    [GVAR(clockPFH)] call CBA_fnc_removePerFrameHandler;
    GVAR(clockPFH) = nil;
};


GVAR(clockPFH) = [
    {
        disableSerialization;
        private _time = format["%1:%2",floor daytime,floor((daytime mod 1)*60)];
        private _control = (findDisplay IDD_TABLET_MAIN) displayCtrl (IDC_TABLET_TOPBAR_CLOCK);
        _control ctrlSetText _time;
        _control ctrlCommit 0;
    },
    1,
    [_dialog]
] call CBA_fnc_addPerFrameHandler;
