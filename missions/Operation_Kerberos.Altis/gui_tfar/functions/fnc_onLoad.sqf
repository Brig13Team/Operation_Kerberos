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

if ([ace_player] call FUNC(canSetFrequencies)) then {
    _ctrlcheckbox cbSetChecked true;
    _ctrlcheckbox ctrlEnable true;
} else {
    _ctrlcheckbox cbSetChecked false;
    _ctrlcheckbox ctrlEnable false;
};

// clear button
(["create",
    [
        _dialog,
        GUI_DISP_X+GUI_DISP_W*132,
        GUI_DISP_Y+GUI_DISP_H*58,
        GUI_DISP_W*10,
        GUI_DISP_H*10
    ]
] call EFUNC(gui,animButton)) params ["_ctrlButton", "_ctrlBackground"];

_ctrlButton ctrlSetText ((parsingNamespace getVariable "MISSION_ROOT")+"gui\data\icons\delete.paa");
_ctrlButton ctrlSetTooltip (localize LSTRING(DISCARD));
_ctrlButton ctrlAddEventHandler ["ButtonClick", LINKFUNC(discard)];
_ctrlBackground ctrlSetTextColor [COLOR_TFAR_DISCARD_SQF];

// set button
(["create",
    [
        _dialog,
        GUI_DISP_X+GUI_DISP_W*146,
        GUI_DISP_Y+GUI_DISP_H*58,
        GUI_DISP_W*10,
        GUI_DISP_H*10
    ]
] call EFUNC(gui,animButton)) params ["_ctrlButton", "_ctrlBackground"];
_ctrlButton ctrlSetText ((parsingNamespace getVariable "MISSION_ROOT")+"gui\data\icons\save.paa");
_ctrlButton ctrlSetTooltip (localize LSTRING(SET));
_ctrlButton ctrlAddEventHandler ["ButtonClick", LINKFUNC(setFrequencies)];
_ctrlBackground ctrlSetTextColor [COLOR_TFAR_SET_SQF];

