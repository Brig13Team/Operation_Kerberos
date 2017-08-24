/**
 * Author: Dorbedo
 * the clock PFH wicht updates the clock
 *
 * Arguments:
 * 0: <DIALOG> the dialog control
 * 1: <SCALAR> PFH-ID
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

disableSerialization;
params ["_dialog", "_handler"];

If ((isNil "_dialog")||{isNull _dialog}) exitWith {
    [_handler] call CBA_fnc_removePerFrameHandler;
};

private _time = format[
    localize LSTRING(DATEFORMAT),
    If ((date select 3)<10) then {format["0%1", (date select 3)]}else{date select 3},
    If ((date select 4)<10) then {format["0%1", (date select 4)]}else{date select 4},
    "<br />",
    If ((date select 2)<10) then {format["0%1", (date select 2)]}else{date select 2},
    If ((date select 1)<10) then {format["0%1", (date select 1)]}else{date select 1},
    date select 0
];

private _control = _dialog displayCtrl (IDC_GUI_MAIN_CLOCK);
_control ctrlSetStructuredText (parsetext _time);
_control ctrlCommit 0;
