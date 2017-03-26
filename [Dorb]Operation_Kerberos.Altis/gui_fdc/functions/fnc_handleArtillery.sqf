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
#include "script_component.hpp"
_this params ["_args","_thisEventHandler"];
_args params ["_vehicle"];

if ((!(player in (crew _vehicle)))||{!(_vehicle getVariable [QGVAR(isActivated),true])}) exitWith {
    GVAR(artilleryHandle) = nil;
    _vehicle setVariable [QGVAR(ready),true];
    [_thisEventHandler] call CBA_fnc_removePerFrameHandler;
};

If !(isNull GVAR(handleCommand)) exitWith {};





GVAR(handleCommand) = [] spawn {




};
