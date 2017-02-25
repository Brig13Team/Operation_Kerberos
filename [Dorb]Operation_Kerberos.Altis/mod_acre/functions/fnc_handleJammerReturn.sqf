/*
 *  Author: Dorbedo
 *
 *  Description:
 *      handles the jammer return and caluclates the px reduction
 *
 *  Parameter(s):
 *      0 : ARRAY - extension call arguments
 *      1 : ARRAY - extension results
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_args", "_result"];
_args params ["_id","_transmitterClass","_receiverClass"];
TRACEV_2(_args,_result);
if (count _result > 0) then {
    _result params ["_extID", "_signal"];
    missionNamespace setVariable [_transmitterClass + "_jammer_signal", (_signal)];
    if (_signal >= -250) then {
        _signal = _signal min -0.001;
        //private _px = (1 - (((log(abs _signal)/log(4))-2.4) max 0)) max 0;
        private _px = (1 - (((log(abs _signal)/log(1.7))-8.6) max 0)) max 0;
        missionNamespace setVariable [_transmitterClass + "_jammer_px", _Px];
    } else {
        missionNamespace setVariable [_transmitterClass + "_jammer_px", 0];
    };
};
