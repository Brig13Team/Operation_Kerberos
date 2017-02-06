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
#define DEBUG_MODE_FULL
#include "script_component.hpp"

CHECK(GVAR(jammer) isEqualTo [])

_this params ["_id","_transmitterClass","_receiverClass","_rxAntenna","_txAntenna","_f","_mw"];

_id = _id + "_jammer";

private _count = missionNamespace getVariable [_transmitterClass + "_running_count_jammer", 0];
TRACE("gettting Jammer");
If (_count <= 0) then {
    {
        _x params ["_jammer","_jammerID","_jammerAntenna","_jammerAntennaDir","_jammeroffset","_jammermw","_jammerf"];
        private _update = [([_jammer] call FUNC(isJammerActive)),{((_jammerf select 0) <= _f) && ((_jammerf select 1) >= _f)}];
        TRACEV_1(_update);
        If (
                ([_jammer] call FUNC(isJammerActive))&&
                call {((_jammerf select 0) <= _f) && ((_jammerf select 1) >= _f)}
            ) then {
            private _jammerpos = AGLToASL(_jammer modelToWorld _jammeroffset);
            {
                private _Antenna = _x;
                //[["ACRE_2HALFINCH_UHF_TNC",B Soldat:2 (Dorbedo),[11611,12018,25.1566],[-0.830366,0.365361,-0.420718]]]
                private _extID = format["%1_%2_%3",_id,_jammerID,_forEachIndex];
                TRACEV_4(_jammer,_jammerID,_Antenna,_extID);
                _count = _count + 1;
                missionNamespace setVariable [_transmitterClass + "_running_count_jammer", _count];
                [
                    "process_signal",
                    [
                        _extID,
                        _jammerpos,
                        _jammerAntennaDir,
                        _jammerAntenna,
                        (_Antenna select 2),
                        (_Antenna select 3),
                        (_Antenna select 0),
                        _f,
                        _mW,
                        acre_sys_signal_terrainScaling,
                        diag_tickTime,
                        ACRE_SIGNAL_DEBUGGING,
                        acre_sys_signal_omnidirectionalRadios
                    ],
                    true,
                    FUNC(handleJammerReturn),
                    [_id,_transmitterClass,_receiverClass]
                ] call acre_sys_core_fnc_callExt;
            } forEach [_rxAntenna,_txAntenna];
        };
    } forEach GVAR(jammer);
};
