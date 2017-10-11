/**
 * Author: Dorbedo
 * onLoad Event
 *
 * Arguments:
 * 0: <DISPLAY> the crate display
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

disableSerialization;
params ["_display"];


// load
(["createText",
    [
        _display,
        GUI_DISP_X + GUI_DISP_W*90,
        GUI_DISP_Y + GUI_DISP_H*74,
        GUI_DISP_W*10,
        GUI_DISP_H*10
    ]
] call EFUNC(gui,animButton)) params ["_ctrlButton", "_ctrlBackground"];
_ctrlButton ctrlSetText (localize LSTRING(BTTN_LOAD));
_ctrlButton ctrlSetTooltip (localize LSTRING(BTTN_LOAD));
_ctrlButton ctrlAddEventHandler ["ButtonClick",{[] call FUNC(load)}];
_ctrlBackground ctrlSetTextColor [COLOR_CRATE_BTTN_LOAD];

// save
(["createText",
    [
        _display,
        GUI_DISP_X + GUI_DISP_W*90,
        GUI_DISP_Y + GUI_DISP_H*80,
        GUI_DISP_W*10,
        GUI_DISP_H*5
    ]
] call EFUNC(gui,animButton)) params ["_ctrlButton", "_ctrlBackground"];
_ctrlButton ctrlSetText (localize LSTRING(BTTN_SAVE));
_ctrlButton ctrlSetTooltip (localize LSTRING(BTTN_SAVE));
_ctrlButton ctrlAddEventHandler ["ButtonClick",{[] call FUNC(save)}];
_ctrlBackground ctrlSetTextColor [COLOR_CRATE_BTTN_SAVE];

// clear
(["createText",
    [
        _display,
        GUI_DISP_X + GUI_DISP_W*140,
        GUI_DISP_Y + GUI_DISP_H*74,
        GUI_DISP_W*10,
        GUI_DISP_H*5
    ]
] call EFUNC(gui,animButton)) params ["_ctrlButton", "_ctrlBackground"];
_ctrlButton ctrlSetText (localize LSTRING(BTTN_CLEAR));
_ctrlButton ctrlSetTooltip (localize LSTRING(BTTN_CLEAR));
_ctrlButton ctrlAddEventHandler ["ButtonClick",{[] call FUNC(clear)}];
_ctrlBackground ctrlSetTextColor [COLOR_CRATE_BTTN_CLEAR];

// spawn
(["createText",
    [
        _display,
        GUI_DISP_X + GUI_DISP_W*140,
        GUI_DISP_Y + GUI_DISP_H*80,
        GUI_DISP_W*10,
        GUI_DISP_H*5
    ]
] call EFUNC(gui,animButton)) params ["_ctrlButton", "_ctrlBackground"];
_ctrlButton ctrlSetText (localize LSTRING(BTTN_SPAWN));
_ctrlButton ctrlSetTooltip (localize LSTRING(BTTN_SPAWN));
_ctrlButton ctrlAddEventHandler ["ButtonClick",{[] call FUNC(spawn)}];
_ctrlBackground ctrlSetTextColor [COLOR_CRATE_BTTN_SPAWN];














