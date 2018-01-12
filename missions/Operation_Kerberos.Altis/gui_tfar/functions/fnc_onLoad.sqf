/*
 *  Author: Dorbedo
 *
 *  Description:
 *      starts general display functions
 *
 *  Parameter(s):
 *      0: DIALOG - the radio-dialog
 *
 *  Returns:
 *      none
 *
 */
#define INCLUDE_GUI
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

disableSerialization;
params ["_dialog"];

[_dialog] call FUNC(treeShow);
[_dialog] call FUNC(editShow);

private _ctrlcheckbox = _dialog displayCtrl IDC_TFAR_CHECKBOX;

_ctrlcheckbox cbSetChecked ([ace_player] call FUNC(canSetFrequencies));
