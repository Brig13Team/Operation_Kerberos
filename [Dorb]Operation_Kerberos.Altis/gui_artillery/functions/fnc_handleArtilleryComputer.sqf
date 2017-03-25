/*
 *  Author: Dorbedo
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
_args params ["_vehicle","_player"];

If !(_player isEqualTo (commander _vehicle)) exitWith {
    GVAR(handleArtilleryComputer) = nil;
    [_thisEventHandler] call CBA_fnc_removePerFrameHandler;
    [_vehicle] call FUNC(deactivateArtillery);
};

CHECK(GVAR(fireCommands) isEqualTo [])

CHECK(!(_vehicle getVariable [QGVAR(ready),true]))

_vehicle setVariable [QGVAR(ready),false];
[_vehicle] spawn FUNC(execFireCommand);




//
