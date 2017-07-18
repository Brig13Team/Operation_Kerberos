/*
 *  Author: Dorbedo
 *
 *  Description:
 *      a simple Jammer calculation
 *      it ignores the terrain and just uses some kind of free space model
 *
 *  Parameter(s):
 *      0 : STRING - Transmitter radio classname
 *      1 : SCALAR - jammer power
 *      2 : SCALAR - jammed frequency
 *      3 : SCALAR - distance of the jammer to the perpenticular
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_transmitterClass","_jammermW","_jammedFrequenz","_distance"];
TRACEV_4(_transmitterClass,_jammermW,_jammedFrequenz,_distance);
// prevent the infinity
_distance = _distance max 1;

private _transmittPower = 10 * (log ((_jammermW)/1000)) + 30;
private _freeSpaceLoss = (-27.44 + 20*log(_jammedFrequenz) + 20*log(_distance));

private _jammerstrength = _transmittPower - _freeSpaceLoss - 20;
TRACEV_3(_jammerstrength,_transmittPower,_freeSpaceLoss);
// no jamming
If (_jammerstrength <= -110) exitWith {
    missionNamespace setVariable [_transmitterClass + "_jammer_signal", 0];
    missionNamespace setVariable [_transmitterClass + "_jammer_px", 0];
};

//private _signal = 10 * (_jammerstrength + 40);
//private _px = (_signal/110) min 1;

missionNamespace setVariable [_transmitterClass + "_jammer_signal", _jammerstrength];

_jammerstrength = _jammerstrength min -0.001;
private _px = (1 - (((log(abs _jammerstrength)/log(1.5))-9.3) max 0)) max 0;

missionNamespace setVariable [_transmitterClass + "_jammer_px", _px];
TRACEV_2(_jammerstrength,_px);
