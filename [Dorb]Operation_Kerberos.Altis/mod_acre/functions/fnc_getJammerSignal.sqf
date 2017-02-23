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

// select the best jammer
(["_transmitterClass","_receiverClass","_rxAntenna","_txAntenna","_f","_mw"] call FUNC(selectBestJammer)) params ["_bestJammer","_calcPos","_calcDistance"];

If (isNull _bestJammer) exitWith {
    // reset the jammervalues
    missionNamespace setVariable [_transmitterClass + "_jammer_signal", 0];
    missionNamespace setVariable [_transmitterClass + "_jammer_px", 0];
};
([_jammer] call FUNC(getJammerArray)) params ["_jammer","_jammerID","_jammerAntenna","_jammerAntennaDir","_jammeroffset","_jammermW","_jammerF"];
private _jammerpos = AGLToASL(_jammer modelToWorld _jammeroffset);

if !(GVAR(advancedjammer)) exitWith {
    [_transmitterClass,_jammermW,_jammerF,_calcDistance] call FUNC(getJammerSignalSimple);
};

If ((missionNamespace getVariable [_transmitterClass + "_jammer_signal", 0])==0) then {
    // this is used to prevent radio contact during jammer initialization
    [_transmitterClass,_jammermW,_f,_calcDistance] call FUNC(getJammerSignalSimple);
};

//[["ACRE_2HALFINCH_UHF_TNC",B Soldat:2 (Dorbedo),[11611,12018,25.1566],[-0.830366,0.365361,-0.420718]]]
private _extID = format["%1_%2_%3",_id,_jammerID,_txAntenna];
[
    "process_signal",
    [
        _extID,
        _jammerpos,
        _jammerAntennaDir,
        _jammerAntenna,
        //(_txAntenna select 2),
        //(_txAntenna select 3),
        //(_txAntenna select 0),
        _calcPos,
        (_txAntenna select 3),
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
    [_id,_transmitterClass,_receiverClass]
] call acre_sys_core_fnc_callExt;
