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
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_args","_handler"];

_args params ["_antenna","_radioID"];

private _radioPos = [_radioID] call arce_sys_radio_fnc_getRadioPos;

If ((_radioPos distance2D _radioPos)<10) exitWith {};
[_handler] call CBA_fnc_removePerFrameHandler;




/*
acre_sys_data_radioData getVariable "ACRE_PRC117F_ID_1" getVariable "acre_radioConnectionData"
*/
