/*
    Author: Dorbedo
    
    Description:
        Displays the timer
        called via publicVariableEventhandler
    
    Parameter(s):
        None
        
    
*/
#include "script_component.hpp"
CHECK(!hasInterface)
CHECK(isNil QEGVAR(mission,endzeit))
#define DISP_LAYER 700103
private _endtime = EGVAR(mission,endzeit);
private _currenttime = if (ismultiplayer) then {servertime} else {time};
private _difference = _endtime - _currenttime;
If (_difference <= 0) exitWith {
    //// disable timer
    DISP_LAYER cutText ["","PLAIN"];
    uiNamespace setvariable [QGVAR(disp_timer),nil];
};

//// show timer
DISP_LAYER cutRsc [QGVAR(disp_timer),"PLAIN"];
disableSerialization;
private _display = uiNamespace getvariable QGVAR(disp_timer);
/// set current time
if (!isNull _display) then {
    private _headerCtrl = _display displayCtrl 700104;
    _headerCtrl ctrlSetText format["%1",(floor(_difference/60))];
};
/// call timer again
uisleep 60;
[] call FUNC(disp_timer);