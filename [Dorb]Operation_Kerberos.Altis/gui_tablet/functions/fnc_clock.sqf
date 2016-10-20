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

_this params [["_dialog",controlNull,[controlNull]]];

IF !(dialog) exitWith {
    [GVAR(clockPFH)] call CBA_fnc_removeEventHandler;
    GVAR(clockPFH) = nil;
};

If ((isNil "_dialog")&&{isNull _dialog}) exitWith {
    [GVAR(clockPFH)] call CBA_fnc_removeEventHandler;
    GVAR(clockPFH) = nil;
};

if !(isNil QGVAR(clockPFH)) then {
    [GVAR(clockPFH)] call CBA_fnc_removeEventHandler;
    GVAR(clockPFH) = nil;
};


GVAR(clockPFH) = [
    {
        _this params ["_dialog"];
        private _time = format["%1:%2",floor daytime,(daytime mod 1)*60];
        private _control = _dialog displayCtrl (IDC_TABLET_CLOCK);
        _control ctrlSetText _time;
    },
    1,
    [_dialog]
] call CBA_fnc_addPerFrameHandler;
