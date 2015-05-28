/*
	Author: Dorbedo
	
	Description:
	
	Requirements:
	
	Parameter(s):
		0 : ARRAY	- Example
		1 : ARRAY	- Example
		2 : STRIN	- Example
	
	Return
	BOOL
*/
#include "makros.hpp"

CHECK(isDedicated)

private ["_timeToWait","_cond","_onfailure","_onSuccess","_args","_dialog","_ctrl","_newStatus","_start","_return"];
_timeToWait = _this select 0;
_cond = [_this, 1, {true}, [{true}]] call BIS_fnc_Param;
_onSuccess = [_this, 2, {}, [{}]] call BIS_fnc_Param;
_onfailure = [_this, 3, {}, [{}]] call BIS_fnc_Param;
_args = [_this, 4, [], [[]]] call BIS_fnc_Param;

hint "test";
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
_return