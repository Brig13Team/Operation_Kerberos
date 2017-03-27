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
[] call FUNC(showOrders);

private _time = missionStart;
private _timectrl = _display displayCTRL IDC_ARTILLERY_TIME;
_timectrl ctrlSetText format["%1%2-%3",
    If ((_time select 3)<10) then {format["0%1",_time select 3]}else{_time select 3},
    If ((_time select 4)<10) then {format["0%1",_time select 4]}else{_time select 4},
    If ((_time select 5)<10) then {format["0%1",_time select 5]}else{_time select 5}
];

private _ctrlGrp = _display displayCTRL IDC_ARTILLERY_NETWORK;
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_NETWORK_ID;
_ctrl ctrlSetText (GVAR(curArtillery) getVariable [QGVAR(networkID),"XX-0000"]);

[] call FUNC(checkInput);

private _ctrlGrp = _display displayCTRL IDC_ARTILLERY_LOCATION;
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_USECURRENT;
If (cbChecked _ctrl) then {
    private _posASL = getPosASL GVAR(curArtillery);
    private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_EAST;
    _ctrl ctrlSetText format["%1",_posASL select 0];
    private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_NORTH;
    _ctrl ctrlSetText format["%1",_posASL select 1];
    private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_ALT;
    _ctrl ctrlSetText format["%1",_posASL select 2];
};

private _ctrlGrp = _display displayCTRL IDC_ARTILLERY_CONTROL;
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_CONTROL_STATE;
private _artState = GVAR(curArtillery) getVariable [QGVAR(state),0];
_ctrl ctrlSetText (localize format[LSTRING(CONTROL_STATE_%1),_artState]);
