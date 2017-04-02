/*
 *  Author: Dorbedo
 *
 *  Description:
 *      selects the best jammer (the jammer with the shortest distance)
 *
 *  Parameter(s):
 *      0 : STRING - transmitting radioclass
 *      1 : STRING - receving radioclass
 *      2 : ARRAY - transmitting antenna data
 *      3 : ARRAY - receving antenna data
 *      4 : SCALAR - sending frequency
 *      5 : SCALAR - sending power
 *
 *  Returns:
 *      ARRAY - [jammerobject,calculation position, distance between jammer and calc pos]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_transmitterClass","_receiverClass","_rxAntenna","_txAntenna","_f","_mw"];

//[["ACRE_120CM_VHF_TNC",B Soldat:2 (Dorbedo),[11610.5,12018.2,26.1889],[-0.828552,0.369331,-0.420827]]]

private _posSender = _txAntenna select 2;
private _posReceiver = _rxAntenna select 2;

private _bestJammer = objNull;
private _bestPos = [];
private _bestdistance = 999999;

{
    _x params ["_jammer","_jammerID","_jammerAntenna","_jammerAntennaDir","_jammeroffset","_jammermW","_jammerF"];
    If ([_jammer] call FUNC(jammer_isActive)) then {
        private _jammerPos = AGLToASL(_jammer modelToWorld _jammeroffset);
        // check the frequency
        TRACEV_8(_jammerPos,_jammer,_jammerID,_jammerAntenna,_jammerAntennaDir,_jammeroffset,_jammermW,_jammerF);
        If ((_jammerF isEqualTo [])||{((_jammerF select 0)<_f)&&((_jammerF select 1)>_f)}) then {
            // get the point of the shortest distance between jammer and a line between the sender and receiver
            private _perpendicular = _posSender vectorAdd (_posReceiver vectorMultiply((_posReceiver vectorDotProduct (_jammerPos vectorDiff _posSender))/(vectorMagnitude _posReceiver)^2));
            private _distance = _jammerPos distance _perpendicular;
            TRACEV_2(_perpendicular,_distance);
            If (_distance < _bestdistance) then {
                _bestdistance = _distance;
                _bestPos = _perpendicular;
                _bestJammer = _jammer;
            };
        };
    };
} forEach GVAR(jammer);

If !(_bestPos isEqualTo []) then {
    _bestPosATL = ASLToATL _bestPos;

    If ((_bestPosATL select 2)<0) then {
        _bestPosATL set [2,0.8];
        _bestPos = ATLtoASL _bestPosATL;
    };
};
[_bestJammer,_bestPos,_bestdistance];
