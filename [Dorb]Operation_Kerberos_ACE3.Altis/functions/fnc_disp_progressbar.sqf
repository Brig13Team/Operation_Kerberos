/*
	Author: Dorbedo
	
	Description:
		Progessbar RSC
*/
#include "script_component.hpp"
SCRIPT(disp_progressbar);
CHECK(isDedicated)
PARAMS_1(_timeToWait);
DEFAULT_PARAM(1,_cond,{true});
DEFAULT_PARAM(2,_onSuccess,{});
DEFAULT_PARAM(3,_onfailure,{});
DEFAULT_PARAM(4,_args,[]);
private ["_dialog","_ctrl","_newStatus","_start","_return"];

if (_timeToWait > 0) then {
	disableSerialization;
	700705 cutRsc ["DORB_DISP_PROGRESSBAR","plain"];
	_dialog = uiNamespace getvariable "DORB_DISP_PROGRESSBAR";
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