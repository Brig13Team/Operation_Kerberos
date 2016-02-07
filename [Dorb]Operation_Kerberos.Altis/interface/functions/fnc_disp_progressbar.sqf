/*
    Author: Dorbedo
    
    Description:
        Progessbar RSC
*/
#include "script_component.hpp"
CHECK(isDedicated)
_this params[["_timeToWait",1,[1]],["_cond",{true},[{}]],["_onSuccess",{},[{}]],["_onfailure",{},[{}]],["_args",[],[[]]]];
Private _return = false;
if (_timeToWait > 0) then {
    disableSerialization;
    700705 cutRsc [QGVAR(disp_progressbar),"plain"];
    Private _dialog = uiNamespace getvariable QGVAR(disp_progressbar);
    Private _ctrl = _dialog displayCtrl 6;
    Private _newStatus = 0;
    Private _start = diag_tickTime;
    while {(_newStatus <= 1.00 && (call _cond))} do {
        uisleep 0.01;
        _ctrl progressSetPosition _newStatus;
        _newStatus = (diag_tickTime - _start) / _timeToWait;
    };
    700705 cutText ["","plain"];
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