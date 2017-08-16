/*
 *  Author: Dorbedo
 *
 *  Description:
 *      opens the fast ArsenalList
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"

disableSerialization;

_this params ["_display"];

private _names = (missionNamespace getVariable [QGVAR(fastArsenalList),[[],[]]]) select 0;

private _ctrl = _display displayCtrl IDC_ECHIDNA_ARSENAL_LIST;
lbClear _ctrl;
CHECK(_names isEqualTo [])
{
    _ctrl lbAdd _x;
} forEach _names;
_ctrl lbSetCurSel 0;
private _ctrl = _display displayCtrl IDC_ECHIDNA_ARSENAL_BTTN;
_ctrl ctrlAddEventHandler ["ButtonClick",{[] call FUNC(loadFast)}];
