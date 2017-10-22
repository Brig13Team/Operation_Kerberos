/*
 *  Author: Dorbedo
 *
 *  Description:
 *      OnLoading of the Loadingscreen Display-Event
 *
 *  Parameter(s):
 *      0 : DISPLAY - Loading-Display
 *
 *  Returns:
 *      none
 *
 */
#define INCLUDE_GUI
#include "script_component.hpp"

_this params [["_display",displayNull,[displayNull]]];

CHECK(isNull _display)

disableSerialization;
// animate the backGround Noise
[_display] spawn FUNC(noise_square);

// disable the "esc" key
//_display displayAddEventHandler ["KeyDown", {_this params ["_disp","_key"];If (_key == 1) exitWith {true};];



// the spinning of the circle
GVAR(handleLoading) = [
    {
        disableSerialization;
        (_this select 0) params [["_disp",displayNull,[displayNull]]];
        If (isNull _disp) exitWith {[_this select 1] call CBA_fnc_removePerFrameHandler;};
        private _ctrl = _disp displayCtrl IDD_LOADING_CIRCLE;

        private _deg = (_disp getVariable [QGVAR(deg),0]) + 1;
        If (_deg > 360) then {_deg = 0};
        _disp setVariable [QGVAR(deg),_deg];

        _ctrl ctrlSetAngle [
            _deg,
            GUI_DISP_X + GUI_DISP_WAbs/2,
            GUI_DISP_Y + GUI_DISP_HAbs/2
        ];
        _ctrl ctrlCommit 0;
    },
    0,
    [_display]
] call CBA_fnc_addPerFrameHandler;
