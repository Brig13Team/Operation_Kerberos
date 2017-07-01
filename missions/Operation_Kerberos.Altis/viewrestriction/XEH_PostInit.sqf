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



CHECK(!hasInterface)


GVAR(EH) = [
    "cameraView",
    {
        If (!GVAR(active)) exitWith {
            ["cameraView", GVAR(EH)] call CBA_fnc_removePlayerEventHandler;
        };
        [_this select 1, cameraOn] call FUNC(onCameraChanged);
    },
    true
] call CBA_fnc_addPlayerEventHandler;

["vehicle", {
    If ((_this select 0) == player) then {
        ["", cameraOn] call FUNC(onCameraChanged);
    };
},true] call CBA_fnc_addPlayerEventHandler;
