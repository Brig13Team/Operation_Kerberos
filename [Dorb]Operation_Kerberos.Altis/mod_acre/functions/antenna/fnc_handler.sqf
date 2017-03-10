/*
 *  Author: Dorbedo
 *
 *  Description:
 *      watches the
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

_this params ["_args","_handler"];

_args params ["_antenna","_radioID","_condition"];

private _radioPos = [_radioID] call arce_sys_radio_fnc_getRadioPos;

If (((_radioPos distance2D _radioPos)<10)&&
    {[_antenna] call _condition}&&
    {vehicle player == player}
) exitWith {};


[_handler] call CBA_fnc_removePerFrameHandler;
[_antenna] call FUNC(antenna_disconnect);

[
    QEGVAR(gui,message),
    [LSTRING(antenna_disconnect),LSTRING(antenna_disconnect_distance)]
] call CBA_fnc_localEvent;
