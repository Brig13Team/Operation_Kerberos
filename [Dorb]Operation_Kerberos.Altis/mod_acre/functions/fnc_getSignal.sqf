/*
 *  Author: ACRE2-Team, Dorbedo
 *
 *  Description:
 *      this is a copy of acre_sys_signal_fnc_getSignal
 *      with the jammer addition
 *
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
    {
        private _txAntenna = _x;
        {
            private _rxAntenna = _x;
            _count = _count + 1;
            private _id = format["%1_%2_%3_%4", _transmitterClass, (_txAntenna select 0), _receiverClass, (_rxAntenna select 0)];
            [_id,_transmitterClass,_receiverClass,_txAntenna,_rxAntenna,_f,_mw] call FUNC(jammer_getSignal);
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

[_transmitterClass] call FUNC(jammer_getSignalOutput);
