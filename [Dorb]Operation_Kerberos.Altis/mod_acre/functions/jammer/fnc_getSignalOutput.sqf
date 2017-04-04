/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the values for the jammed signal
 *
 *  Parameter(s):
 *      0 : STRING - transmitter class
 *
 *  Returns:
 *      ARRAY - [_Px, _maxSignal]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_transmitterClass"];

private _maxSignal = missionNamespace getVariable [_transmitterClass + "_best_signal", -992];
private _Px = missionNamespace getVariable [_transmitterClass + "_best_px", 0];

if (ACRE_SIGNAL_DEBUGGING > 0) then {
    private _signalTrace = missionNamespace getVariable [_transmitterClass + "_signal_trace", []];
    _signalTrace pushBack _maxSignal;
    missionNamespace setVariable [_transmitterClass + "_signal_trace", _signalTrace];
};

private _jammer_signal = missionNamespace getVariable [_transmitterClass + "_jammer_signal", 0];
private _jammer_px = missionNamespace getVariable [_transmitterClass + "_jammer_px", 0];

_maxSignal = (_maxSignal - _jammer_signal) max -992;
_Px = ((_Px - _jammer_px) min 1)max 0;

#ifdef DEBUG_MODE_FULL
    hintSilent parseText format["Radio:<br />   Px=%1<br />   Signal=%2<br />Jammer:<br />   Px=%3<br />   Signal=%4",_Px,_maxSignal,_jammer_px,_jammer_signal];
#endif

[_Px, _maxSignal];
