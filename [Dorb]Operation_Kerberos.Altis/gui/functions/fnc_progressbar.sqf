/*
    Author: Dorbedo

    Description:
        Progessbar RSC
*/
#define INCLUDE_GUI
#include "script_component.hpp"
CHECK(!hasInterface)
_this params[["_timeToWait",1,[1]],["_cond",{true},[{}]],["_onSuccess",{},[{}]],["_onfailure",{},[{}]],["_args",[],[[]]]];
Private _return = false;
if (_timeToWait > 0) then {
    disableSerialization;
    IDD_PROGRESSBAR cutRsc [QAPP(progressbar),"plain"];
    Private _dialog = uiNamespace getvariable QGVAR(progressbar);
    Private _ctrl = _dialog displayCtrl IDC_PROGRESSBAR_BAR;
    Private _newStatus = 0;
    Private _start = CBA_missionTime;
    while {(_newStatus <= 1.00 && (call _cond))} do {
        uisleep 0.01;
        _ctrl progressSetPosition _newStatus;
        _newStatus = (CBA_missionTime - _start) / _timeToWait;
    };
    IDD_PROGRESSBAR cutText ["","plain"];
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
