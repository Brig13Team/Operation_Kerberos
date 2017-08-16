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

private _radioPos = [toLower _radioID] call acre_sys_radio_fnc_getRadioPos;
TRACEV_5(_antenna,_radioID,_condition,_radioPos,(_antenna distance2D _radioPos));
If (((_antenna distance2D _radioPos)<5)&&
    {[_antenna] call _condition}&&
    {vehicle player == player}
) exitWith {};


[_handler] call CBA_fnc_removePerFrameHandler;
[_antenna] call FUNC(antenna_disconnect);

[
    QEGVAR(gui,message),
    [LSTRING(antenna_disconnect),LSTRING(antenna_disconnect_distance)]
] call CBA_fnc_localEvent;
