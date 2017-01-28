/*
 *  Author: Dorbedo
 *
 *  Description:
 *      clock per Frame handler
 *
 *  Parameter(s):
 *      0 : DIALOG - dialog control
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
disableSerialization;
_this params ["_dialog","_PFH_ID"];
If ((isNil "_dialog")||{isNull _dialog}) exitWith {
    [_PFH_ID] call CBA_fnc_removePerFrameHandler;
};
disableSerialization;
private _time = format["%1:%2",
    (floor daytime),
    If ((floor((daytime mod 1)*60))<10) then {format["0%1",(floor((daytime mod 1)*60))]}else{(floor((daytime mod 1)*60))}
];
private _control = _dialog displayCtrl (IDC_TABLET_TOPBAR_CLOCK);
_control ctrlSetText _time;
_control ctrlCommit 0;
