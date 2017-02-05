/*
 *  Author: Dorbedo
 *  Original Author: ACRE2-Team
 *
 *  Description:
 *      this function modifies the acre_sys_signal_fnc_getSignal function
 *      the target is to use jammer
 *
 *  Parameter(s):
 *      0 : SCALAR - frequenz
 *      0 : SCALAR - transmitting power
 *      0 : STRING - Receiver classname
 *      0 : STRING - Sender classname
 *
 *  Returns:
 *      ARRAY - [strength of signal(0-1),decibel signal strenght]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"



_this params ["_f", "_mW", "_receiverClass", "_transmitterClass"];

private _count = missionNamespace getVariable [_transmitterClass + "_running_count", 0];
if (_count == 0) then {
    private _rxAntennas = [_receiverClass] call acre_sys_components_fnc_findAntenna;
    //[["ACRE_120CM_VHF_TNC",B Soldat:2 (Dorbedo),[11610.5,12018.2,26.1889],[-0.828552,0.369331,-0.420827]]]
    private _txAntennas = [_transmitterClass] call acre_sys_components_fnc_findAntenna;
    //[["ACRE_2HALFINCH_UHF_TNC",B Soldat:2 (Dorbedo),[11611,12018,25.1566],[-0.830366,0.365361,-0.420718]]]
    //
    {
        private _txAntenna = _x;
        {
            private _rxAntenna = _x;
            _count = _count + 1;
            private _id = format["%1_%2_%3_%4", _transmitterClass, (_txAntenna select 0), _receiverClass, (_rxAntenna select 0)];
            [
                "process_signal",
                [
                    _id,
                    (_txAntenna select 2),
                    (_txAntenna select 3),
                    (_txAntenna select 0),
                    (_rxAntenna select 2),
                    (_rxAntenna select 3),
                    (_rxAntenna select 0),
                    _f,
                    _mW,
                    acre_sys_signal_terrainScaling,
                    diag_tickTime,
                    ACRE_SIGNAL_DEBUGGING,
                    acre_sys_signal_omnidirectionalRadios
                ],
                true,
                acre_sys_signal_fnc_handleSignalReturn,
                [_transmitterClass, _receiverClass]
            ] call acre_sys_core_fnc_callExt;
        } forEach _rxAntennas;
    } forEach _txAntennas;
    missionNamespace setVariable [_transmitterClass + "_running_count", _count];
};
private _maxSignal = missionNamespace getVariable [_transmitterClass + "_best_signal", -992];
private _Px = missionNamespace getVariable [_transmitterClass + "_best_px", 0];

if (ACRE_SIGNAL_DEBUGGING > 0) then {
    private _signalTrace = missionNamespace getVariable [_transmitterClass + "_signal_trace", []];
    _signalTrace pushBack _maxSignal;
    missionNamespace setVariable [_transmitterClass + "_signal_trace", _signalTrace];
};
[_Px, _maxSignal];
