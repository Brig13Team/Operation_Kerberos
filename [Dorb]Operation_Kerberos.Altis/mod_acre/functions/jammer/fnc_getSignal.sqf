/*
 *  Author: Dorbedo
 *
 *  Description:
 *      calculates the jammer signal
 *
 *  Parameter(s):
 *      0 : STRING - the unique id of the signal call
 *      1 : STRING - transmitting radioclass
 *      2 : STRING - receiving radioclass
 *      3 : ARRAY - transmitting antenna data
 *      4 : ARRAY - receving antenna data
 *      5 : SCALAR - sending frequency
 *      6 : SCALAR - sending power
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

CHECK(GVAR(jammer) isEqualTo [])

_this params ["_id","_transmitterClass","_receiverClass","_txAntenna","_rxAntenna","_f","_mw"];
TRACEV_7(_id,_transmitterClass,_receiverClass,_rxAntenna,_txAntenna,_f,_mW);
_id = _id + "_jammer";

// select the best jammer
([_transmitterClass,_receiverClass,_rxAntenna,_txAntenna,_f,_mw] call FUNC(jammer_selectBest)) params ["_bestJammer","_calcPos","_calcDistance"];
TRACEV_3(_bestJammer,_calcPos,_calcDistance);
If (isNull _bestJammer) exitWith {
    // reset the jammervalues
    missionNamespace setVariable [_transmitterClass + "_jammer_signal", 0];
    missionNamespace setVariable [_transmitterClass + "_jammer_px", 0];
};
([_bestJammer] call FUNC(jammer_getArray)) params ["_jammer","_jammerID","_jammerAntenna","_jammerAntennaDir","_jammeroffset","_jammermW","_jammerF"];
private _jammerpos = AGLToASL(_jammer modelToWorld _jammeroffset);
TRACEV_7(_jammer,_jammerID,_jammerAntenna,_jammerAntennaDir,_jammeroffset,_jammermW,_jammerF);
if !(GVAR(advancedjammer)) exitWith {
    [_transmitterClass,_jammermW,_f,_calcDistance] call FUNC(jammer_getSignalSimple);
};

If ((missionNamespace getVariable [_transmitterClass + "_jammer_signal", 0])==0) then {
    // this is used to prevent radio contact during jammer initialization
    [_transmitterClass,_jammermW,_f,_calcDistance] call FUNC(jammer_getSignalSimple);
};

private _extID = format["%1_%2_%3",_id,_jammerID,_transmitterClass];
TRACEV_9(_extID,_jammerpos,_jammerAntennaDir,_jammerAntenna,_calcPos,(_txAntenna select 3),(_rxAntenna select 0),_f,_mw);
[
    "process_signal",
    [
        _extID,
        _jammerpos,
        _jammerAntennaDir,
        _jammerAntenna,
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
    FUNC(jammer_handleReturn),
    [_id,_transmitterClass,_receiverClass]
] call acre_sys_core_fnc_callExt;
