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

_display displayAddEventHandler ["KeyDown",QUOTE([ARR_2(_this select 1,true)] call FUNC(keyEvent);false)];
_display displayAddEventHandler ["KeyUp",QUOTE([ARR_2(_this select 1,false)] call FUNC(keyEvent);false)];

// load
(["createText",
    [
        _display,
        GUI_DISP_X + GUI_DISP_W*82,
        GUI_DISP_Y + GUI_DISP_H*78,
        GUI_DISP_H*10,
        GUI_DISP_H*10
    ]
] call EFUNC(gui,animButton)) params ["_ctrlButton", "_ctrlBackground"];
_ctrlButton ctrlSetFontHeight (GUI_DISP_H*2);
_ctrlButton ctrlSetText (localize LSTRING(BTTN_LOAD));
_ctrlButton ctrlSetTooltip (localize LSTRING(BTTN_LOAD));
_ctrlButton ctrlAddEventHandler ["ButtonClick",{[_this select 0] spawn FUNC(load)}];
_ctrlBackground ctrlSetTextColor [COLOR_CRATE_BTTN_LOAD];

// save
(["createText",
    [
        _display,
        GUI_DISP_X + GUI_DISP_W*94,
        GUI_DISP_Y + GUI_DISP_H*78,
        GUI_DISP_H*10,
        GUI_DISP_H*10
    ]
] call EFUNC(gui,animButton)) params ["_ctrlButton", "_ctrlBackground"];
_ctrlButton ctrlSetFontHeight (GUI_DISP_H*2);
_ctrlButton ctrlSetText (localize LSTRING(BTTN_SAVE));
_ctrlButton ctrlSetTooltip (localize LSTRING(BTTN_SAVE));
_ctrlButton ctrlAddEventHandler ["ButtonClick",{[_this select 0] call FUNC(save)}];
_ctrlBackground ctrlSetTextColor [COLOR_CRATE_BTTN_SAVE];

// clear
(["createText",
    [
        _display,
        GUI_DISP_X + GUI_DISP_W*106,
        GUI_DISP_Y + GUI_DISP_H*78,
        GUI_DISP_H*10,
        GUI_DISP_H*10
    ]
] call EFUNC(gui,animButton)) params ["_ctrlButton", "_ctrlBackground"];
_ctrlButton ctrlSetFontHeight (GUI_DISP_H*2);
_ctrlButton ctrlSetText (localize LSTRING(BTTN_CLEAR));
_ctrlButton ctrlSetTooltip (localize LSTRING(BTTN_CLEAR));
_ctrlButton ctrlAddEventHandler ["ButtonClick",{[_this select 0] call FUNC(clear)}];
_ctrlBackground ctrlSetTextColor [COLOR_CRATE_BTTN_CLEAR];

// clearPos
(["createText",
    [
        _display,
        GUI_DISP_X + GUI_DISP_W*128,
        GUI_DISP_Y + GUI_DISP_H*78,
        GUI_DISP_H*10,
        GUI_DISP_H*10
    ]
] call EFUNC(gui,animButton)) params ["_ctrlButton", "_ctrlBackground"];
_ctrlButton ctrlSetFontHeight (GUI_DISP_H*2);
_ctrlButton ctrlSetText (localize LSTRING(BTTN_CLEARPOS));
_ctrlButton ctrlSetTooltip (localize LSTRING(BTTN_CLEARPOS));
_ctrlButton ctrlAddEventHandler ["ButtonClick",{[] call FUNC(clearPosition)}];
_ctrlBackground ctrlSetTextColor [COLOR_CRATE_BTTN_CLEARPOS];


// spawn
(["createText",
    [
        _display,
        GUI_DISP_X + GUI_DISP_W*140,
        GUI_DISP_Y + GUI_DISP_H*78,
        GUI_DISP_H*10,
        GUI_DISP_H*10
    ]
] call EFUNC(gui,animButton)) params ["_ctrlButton", "_ctrlBackground"];
_ctrlButton ctrlSetFontHeight (GUI_DISP_H*2);
_ctrlButton ctrlSetText (localize LSTRING(BTTN_SPAWN));
_ctrlButton ctrlSetTooltip (localize LSTRING(BTTN_SPAWN));
_ctrlButton ctrlAddEventHandler ["ButtonClick",{[_this select 0] call FUNC(setInventory)}];
_ctrlBackground ctrlSetTextColor [COLOR_CRATE_BTTN_SPAWN];

(_display displayCtrl IDC_GUI_CRATE_BTTN1) ctrlAddEventHandler ["ButtonClick",{[(_this select 0),ID_RIFLE] call FUNC(filterList)}];
(_display displayCtrl IDC_GUI_CRATE_BTTN2) ctrlAddEventHandler ["ButtonClick",{[(_this select 0),ID_AUTOMATIC] call FUNC(filterList)}];
(_display displayCtrl IDC_GUI_CRATE_BTTN3) ctrlAddEventHandler ["ButtonClick",{[(_this select 0),ID_SNIPER] call FUNC(filterList)}];
(_display displayCtrl IDC_GUI_CRATE_BTTN4) ctrlAddEventHandler ["ButtonClick",{[(_this select 0),ID_LAUNCHER] call FUNC(filterList)}];
(_display displayCtrl IDC_GUI_CRATE_BTTN5) ctrlAddEventHandler ["ButtonClick",{[(_this select 0),ID_HANDGUN] call FUNC(filterList)}];
(_display displayCtrl IDC_GUI_CRATE_BTTN6) ctrlAddEventHandler ["ButtonClick",{[(_this select 0),ID_OPTICS] call FUNC(filterList)}];
(_display displayCtrl IDC_GUI_CRATE_BTTN7) ctrlAddEventHandler ["ButtonClick",{[(_this select 0),ID_GRANADES] call FUNC(filterList)}];
(_display displayCtrl IDC_GUI_CRATE_BTTN8) ctrlAddEventHandler ["ButtonClick",{[(_this select 0),ID_MINES] call FUNC(filterList)}];
(_display displayCtrl IDC_GUI_CRATE_BTTN9) ctrlAddEventHandler ["ButtonClick",{[(_this select 0),ID_UNIFORM] call FUNC(filterList)}];
(_display displayCtrl IDC_GUI_CRATE_BTTN10) ctrlAddEventHandler ["ButtonClick",{[(_this select 0),ID_VEST] call FUNC(filterList)}];
(_display displayCtrl IDC_GUI_CRATE_BTTN11) ctrlAddEventHandler ["ButtonClick",{[(_this select 0),ID_HEADGEAR] call FUNC(filterList)}];
(_display displayCtrl IDC_GUI_CRATE_BTTN12) ctrlAddEventHandler ["ButtonClick",{[(_this select 0),ID_BACKPACK] call FUNC(filterList)}];
(_display displayCtrl IDC_GUI_CRATE_BTTN13) ctrlAddEventHandler ["ButtonClick",{[(_this select 0),ID_RADIO] call FUNC(filterList)}];
(_display displayCtrl IDC_GUI_CRATE_BTTN14) ctrlAddEventHandler ["ButtonClick",{[(_this select 0),ID_NAVIGATION] call FUNC(filterList)}];
(_display displayCtrl IDC_GUI_CRATE_BTTN15) ctrlAddEventHandler ["ButtonClick",{[(_this select 0),ID_MEDIC] call FUNC(filterList)}];
(_display displayCtrl IDC_GUI_CRATE_BTTN16) ctrlAddEventHandler ["ButtonClick",{[(_this select 0),ID_OTHER] call FUNC(filterList)}];

[(_display displayCtrl IDC_GUI_CRATE_ITEMLIST),GVAR(curItemList) select GVAR(curID)] call FUNC(showItemList);
[_display] call FUNC(showBoxes);
[_display displayCtrl IDC_GUI_CRATE_BTTN1,ID_RIFLE] call FUNC(filterList);

private _ctrlLb = _display displayCtrl IDC_GUI_CRATE_BOXLIST;
_ctrlLb lbSetCurSel 0;
_ctrlLb ctrlAddEventHandler ["LBSelChanged",LINKFUNC(onBoxSelect)];
[_ctrlLb,0] call FUNC(onBoxSelect);


If (isNil QGVAR(FilterHandleID)) then {
    private _ctrlWatermark = _display displayCtrl IDC_GUI_CRATE_FILTER_WATERMARK;
    private _ctrlEditBox = _display displayCtrl IDC_GUI_CRATE_FILTER;

    GVAR(FilterHandleID) = [
        LINKFUNC(filterPFH),
        0.5,
        [
            _display,
            _ctrlWatermark,
            _ctrlEditBox
        ]
    ] call CBA_fnc_addPerFrameHandler;
};
