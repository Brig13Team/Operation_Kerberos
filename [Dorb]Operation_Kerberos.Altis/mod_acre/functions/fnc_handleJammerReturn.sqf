/*
 *  Author: [Name of Author(s)]
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

params ["_args", "_result"];
_args params ["_id","_transmitterClass","_receiverClass"];

if (count _result > 0) then {
    _result params ["_extID", "_signal"];
    missionNamespace setVariable [_transmitterClass + "_jammer_signal", _signal];
    if (_signal >= -500) then {
        private _Px = (((501 + _signal)/500) max 0) min 1;
        missionNamespace setVariable [_transmitterClass + "_jammer_px", _Px];
    } else {
        missionNamespace setVariable [_transmitterClass + "_jammer_px", 0];
    };

};
