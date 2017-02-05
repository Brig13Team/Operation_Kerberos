/*
 *  Author: Dorbedo
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

CHECK(GVAR(jammer) isEqualTo [])

_this params ["_id","_receiverClass","_rxAntennas","_transmitterClass","_txAntennas","_f","_mw"];

_id = _id + "_jammer";

private _count = missionNamespace getVariable [_transmitterClass + "_running_count_jammer", 0];
If (_count == 0) then {
    {
        _x params ["_jammer","_jammerAntenna","_jammerAntennaDir","_jammeroffset","_jammermw","_jammerf"];
        If ((_jammerf isEqualTo [])||{((_jammerf select 0) < _f) && ((_jammerf select 1) > f)}) then {
            private _jammerpos = AGLToASL (_jammer modelToWorld _jammeroffset);
            {
                private _rxAntenna = _x;
                //[["ACRE_2HALFINCH_UHF_TNC",B Soldat:2 (Dorbedo),[11611,12018,25.1566],[-0.830366,0.365361,-0.420718]]]
                _count = _count + 1;
                [
                    "process_signal",
                    [
                        _id,
                        _jammerpos,
                        _jammerAntennaDir,
                        _jammerAntenna,
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
                    FUNC(handleJammerReturn),
                    []
                ] call acre_sys_core_fnc_callExt;
                missionNamespace setVariable [_transmitterClass + "_running_count_jammer", _count];
            } forEach (_rxAntennas + _txAntennas);
        };
    } forEach (GVAR(jammer) select {[_x] call FUNC(isJammerActive)});
};
