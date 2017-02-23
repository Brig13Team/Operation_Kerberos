/*
 *  Author: Dorbedo
 *
 *  Description:
 *      a simple Jammer calculation
 *      it ignores the terrain and just uses some kind of free space model
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

_this params ["_transmitterClass","_jammermW","_jammedFrequenz","_distance"];

// prevent the infinity
_distance = _distance max 1;

private _transmittPower = 10 * (log ((_jammermW)/1000)) + 30;
private _freeSpaceLoss = (-27.44 + 20*log(_f) + 20*log(_distance));

private _jammerStrenght = _transmittPower - _freeSpaceLoss;

// no jamming
If (_jammerStrenght <= -45) then {
    missionNamespace setVariable [_transmitterClass + "_jammer_signal", 1];
    missionNamespace setVariable [_transmitterClass + "_jammer_px", 0];
};

_signal = 10 * (_jammerStrenght + 45);
_px = (_signal/140) min 1;

missionNamespace setVariable [_transmitterClass + "_jammer_signal", _signal];
missionNamespace setVariable [_transmitterClass + "_jammer_px", _px];
