/*
	Author: Dorbedo
	
	Description:
		Progessbar RSC
*/
#include "script_component.hpp"
SCRIPT(disp_progressbar);
CHECK(isDedicated)
params[["_timeToWait",1,[1]],["_cond",{true},[{}]],["_onSuccess",{},[{}]],["_onfailure",{},[{}]],["_args",[],[[]]]];
private ["_dialog","_ctrl","_newStatus","_start","_return"];

if (_timeToWait > 0) then {
	disableSerialization;
	700705 cutRsc [QGVAR(disp_progressbar),"plain"];
	_dialog = uiNamespace getvariable QGVAR(disp_progressbar);
	_ctrl = _dialog displayCtrl 6;
	_newStatus = 0;
	_start = diag_tickTime;
	while {(_newStatus <= 1.00 && (call _cond))} do {
		uisleep 0.01;
		_ctrl progressSetPosition _newStatus;
		_newStatus = (diag_tickTime - _start) / _timeToWait;
	};
	700705 cutText ["","plain"];
	_return = false;
	if (_newStatus >= 1.00) then {
		_return = true;
		_args call _onSuccess;
	} else {
		_args call _onfailure;
	};
} else {
	if ((call _cond)) then {
		_return = true;
		_args call _onSuccess;
	} else {
		_args call _onfailure;
	};
};
_return;