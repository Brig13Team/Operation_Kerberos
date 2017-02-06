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

TRACEV_3(_result,_transmitterClass,_id);



missionNamespace setVariable [_transmitterClass + "_running_count_jammer", (missionNamespace getVariable [_transmitterClass + "_running_count_jammer", 0])-1];

if (count _result > 0) then {
    _result params ["_id", "_signal"];
    // get the current jammer value
    _signal = (_signal + 992) max 0;
    private _maxSignal = (missionNamespace getVariable [_transmitterClass + "_jammer_signal", 0]);
    private _currentJammer = missionNamespace getVariable [_transmitterClass + "_jammer_id", ""];
    // check if you can update a value or the new value is stronger
    TRACEV_4(_id,_currentJammer,_signal,_maxSignal);
    if (_id == _currentJammer || {(_id != _currentJammer && {_signal > _maxSignal})}) then {
        missionNamespace setVariable [_transmitterClass + "_jammer_signal", _signal];
        missionNamespace setVariable [_transmitterClass + "_jammer_id", _id];
        TRACE("setting values");
        if (_maxSignal >= 500) then {
            _Px = (((_maxSignal / 992) min 1) max 0);
            missionNamespace setVariable [_transmitterClass + "_jammer_px", _Px];
        } else {
            missionNamespace setVariable [_transmitterClass + "_jammer_px", 0];
        };
    };
};
