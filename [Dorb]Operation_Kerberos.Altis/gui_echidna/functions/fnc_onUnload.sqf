/*
 *  Author: Dorbedo
 *
 *  Description:
 *      onUnload Event
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

disableSerialization;
TRACEV_1(_this);
_this params ["_dialog"];

private _clock = _dialog getVariable QGVAR(clockPFH);

if !(isNil "_clock") then {
    [_clock] call CBA_fnc_removePerFrameHandler;
    _dialog setVariable [QGVAR(clockPFH),nil];
};
