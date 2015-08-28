/*
	Author: Dorbedo
	
	Description:
		Displays the timer
		called via publicVariableEventhandler
	
	Parameter(s):
		None
		
	Requirements:
		publicVariable DORB_ENDZEIT
*/
#include "script_component.hpp"
SCRIPT(disp_timer);
CHECK(!hasInterface)
CHECK(isNil "DORB_ENDZEIT")
#define DISP_LAYER 700103
private["_endtime","_currenttime","_difference","_headerCtrl","_display"];
_endtime = EGVAR(mission,endzeit);
_currenttime = if (ismultiplayer) then {servertime} else {time};
_difference = _endtime - _currenttime;
If (_difference <= 0) exitWith {
	//// disable timer
	DISP_LAYER cutText ["","PLAIN"];
	uiNamespace setvariable [QGVAR(disp_timer),nil];
};

//// show timer
DISP_LAYER cutRsc [QGVAR(disp_timer),"PLAIN"];
disableSerialization;
_display = uiNamespace getvariable QGVAR(disp_timer);
/// set current time
if (!isNull _display) then {
	_headerCtrl = _display displayCtrl 700104;
	_headerCtrl ctrlSetText format["%1",(floor(_difference/60))];
};
/// call timer again
uisleep 60;
[] call FUNC(disp_timer);