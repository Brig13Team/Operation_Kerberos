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

_this params ["_ctrl"];

private _state = cbChecked _ctrl;
private _ctrlGrp = ctrlParentControlsGroup _ctrl;
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_EAST;
_ctrl ctrlEnable !_state;
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_NORTH;
_ctrl ctrlEnable !_state;
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_ALT;
_ctrl ctrlEnable !_state;

GVAR(curArtillery) setVariable [QGVAR(location_usecurrent),_state];
