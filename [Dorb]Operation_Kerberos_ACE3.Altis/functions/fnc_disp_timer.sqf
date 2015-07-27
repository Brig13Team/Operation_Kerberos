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
CHECK(!hasInterface)
CHECK(isNil "DORB_ENDZEIT")
#define DISP_LAYER 700103
private["_endtime","_currenttime","_difference","_headerCtrl"];
_endtime = DORB_ENDZEIT;
_currenttime = if (ismultiplayer) then {servertime} else {time};

_difference = _endtime - _currenttime;
LOG_1(_difference);
If (_difference <= 0) exitWith {
	//// disable timer
	DISP_LAYER cutText ["","PLAIN"];
	uiNamespace setvariable ["DORB_DISP_MISSIONTIMER",nil];
};

//// show timer
DISP_LAYER cutRsc ["DORB_DISP_MISSIONTIMER","PLAIN"];
disableSerialization;
_display = uiNamespace getvariable "DORB_DISP_MISSIONTIMER";
/// set current time
if (!isNull _display) then {
	_headerCtrl = _display displayCtrl 700104;
	_headerCtrl ctrlSetText format["%1",(floor(_difference/60))];
};
/// call timer again
uisleep 60;
[] call FM(disp_timer);