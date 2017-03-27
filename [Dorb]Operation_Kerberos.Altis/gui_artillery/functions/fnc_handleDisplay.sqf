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
#define INCLUDE_GUI
#include "script_component.hpp"

_this params ["_args","_thisEventHandler"];
_args params ["_display"];

If (isNull _display) exitWith {
    GVAR(handleDisplay) = nil;
    [_thisEventHandler] call CBA_fnc_removePerFrameHandler;
};

[_display,GVAR(curArtillery)] call FUNC(showArtData);
[_display,GVAR(curArtillery)] call FUNC(showArtAmmo);

private _time = missionStart;
private _timectrl = _display displayCTRL IDC_ARTILLERY_TIME;
_timectrl ctrlSetText format["%1%2-%3",
    If ((_time select 3)<10) then {format["0%1",_time select 3]}else{_time select 3},
    If ((_time select 4)<10) then {format["0%1",_time select 4]}else{_time select 4},
    _time select 5
];

private _ctrlGrp = _display displayCTRL IDC_ARTILLERY_NETWORK;
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_NETWORK_ID;
_ctrl ctrlSetText (GVAR(curArtillery) getVariable [QGVAR(networkID),"XX-0000"]);
