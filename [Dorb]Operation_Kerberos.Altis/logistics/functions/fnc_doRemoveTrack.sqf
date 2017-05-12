/*
 *  Author: Dorbedo
 *
 *  Description:
 *      removes a track from the virtual cargo
 *
 *  Parameter(s):
 *      0 : OBJECT - The vehicle, the track was unloaded
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


_this params ["_target"];

private _amount = (_target getVariable [QGVAR(spareTrackAmount),1])-1;
_target setVariable [QGVAR(spareTrackAmount),_amount,true];

[
    LOADTIME,
    [_target,getPos _target],
    {
        (_this select 0) params ["_target"];
        [_target] call FUNC(removeTrack);
    },
    {
        _this params ["_target"];
        private _amount = (_target getVariable [QGVAR(spareTrackAmount),0])+1;
        _target setVariable [QGVAR(spareTrackAmount),_amount,true];
    },
    "",
    {
        If (((getpos ((_this select 0)select 0)) distance ((_this select 0)select 1)) > 0.5) exitWith {TRACE("Vehicle has been moved"); false };
        true;
    }
] call ace_common_fnc_progressBar;
