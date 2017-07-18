/*
 *  Author: Dorbedo
 *
 *  Description:
 *      handles the timer
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"

private _difference = GVAR(timer_finish) - CBA_missiontime;

If (_difference <= 0) exitWith {
    GVAR(timer_handle) = nil;
    [_this select 1] call CBA_fnc_removePerFrameHandler;

    [GVAR(timer_parameter),GVAR(timer_code)] params [["_params",[],[[]]],["_function",{true},[{},""]]];
    If (IS_STRING(_function)) then {
        [_function,_parameter] call CBA_fnc_localEvent;
    }else{
        _params call _function;
    };

    if (hasInterface) then {
        IDD_TIMER cutText ["","PLAIN"];
        uiNamespace setvariable [QGVAR(timer),nil];
    };
};

CHECK(!hasInterface)

QAPP(timer) cutRsc [QAPP(timer),"PLAIN"];
disableSerialization;
private _display = uiNamespace getvariable QGVAR(timer);
/// set current time
If (_difference > 10) then {
    _difference = format["%1",(floor(_difference/60))];
}else{
    _difference = format["0%1",(floor(_difference/60))];
};

if (!isNull _display) then {
    private _headerCtrl = _display displayCtrl IDC_TIMER_TEXT;
    _headerCtrl ctrlSetText _difference;
};
