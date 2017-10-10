/**
 * Author: Dorbedo
 * onLoad Event
 *
 * Arguments:
 * 0: <DIALOG> the Dialog
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

disableSerialization;
params ["_display"];

private _ctrl = _display displayCtrl IDC_GUI_MAIN_HEADERTEXT;
_ctrl ctrlSetText (localize LSTRING(HEADER));

// informations
(["create",
    [
        _display,
        GUI_DISP_X + GUI_DISP_W*73,
        GUI_DISP_Y + GUI_DISP_H*10,
        GUI_DISP_W*10,
        GUI_DISP_H*10
    ]
] call EFUNC(gui,animButton)) params ["_ctrlButton", "_ctrlBackground"];
_ctrlButton ctrlSetText "\A3\ui_f\data\igui\cfg\simpletasks\types\search_ca.paa";
_ctrlButton ctrlSetTooltip (localize LSTRING(BTTN_INFO));
_ctrlButton ctrlAddEventHandler ["ButtonClick",{["info"] call FUNC(displayProperties)}];
_ctrlBackground ctrlSetTextColor [COLOR_SPAWN_BTTN_INFO_SQF];
// 3D-View
(["create",
    [
        _display,
        GUI_DISP_X + GUI_DISP_W*73,
        GUI_DISP_Y + GUI_DISP_H*21,
        GUI_DISP_W*10,
        GUI_DISP_H*10
    ]
] call EFUNC(gui,animButton)) params ["_ctrlButton", "_ctrlBackground"];
_ctrlButton ctrlSetText "\A3\ui_f\data\igui\cfg\simpletasks\types\search_ca.paa";
_ctrlButton ctrlSetTooltip (localize LSTRING(BTTN_OBJ));
_ctrlButton ctrlAddEventHandler ["ButtonClick",{["picture"] call FUNC(displayProperties)}];
_ctrlBackground ctrlSetTextColor [COLOR_SPAWN_BTTN_PIC_SQF];
// Ammo-Options
(["create",
    [
        _display,
        GUI_DISP_X + GUI_DISP_W*73,
        GUI_DISP_Y + GUI_DISP_H*32,
        GUI_DISP_W*10,
        GUI_DISP_H*10
    ]
] call EFUNC(gui,animButton)) params ["_ctrlButton", "_ctrlBackground"];
_ctrlButton ctrlSetText "\A3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa";
_ctrlButton ctrlSetTooltip (localize LSTRING(BTTN_AMMO));
_ctrlButton ctrlAddEventHandler ["ButtonClick",{["ammo"] call FUNC(displayProperties)}];
_ctrlBackground ctrlSetTextColor [COLOR_SPAWN_BTTN_AMMO_SQF];
// Options
(["create",
    [
        _display,
        GUI_DISP_X + GUI_DISP_W*73,
        GUI_DISP_Y + GUI_DISP_H*43,
        GUI_DISP_W*10,
        GUI_DISP_H*10
    ]
] call EFUNC(gui,animButton)) params ["_ctrlButton", "_ctrlBackground"];
_ctrlButton ctrlSetText "\A3\ui_f\data\GUI\rsc\rscdisplaymain\menu_options_ca.paa";
_ctrlButton ctrlSetTooltip (localize LSTRING(BTTN_OPT));
_ctrlButton ctrlAddEventHandler ["ButtonClick",{["options"] call FUNC(displayProperties)}];
_ctrlBackground ctrlSetTextColor [COLOR_SPAWN_BTTN_OPT_SQF];
// clear the pad
(["create",
    [
        _display,
        GUI_DISP_X + GUI_DISP_WAbs - GUI_DISP_W*14,
        GUI_DISP_Y + GUI_DISP_HAbs - GUI_DISP_H*12,
        GUI_DISP_W*10,
        GUI_DISP_H*10
    ]
] call EFUNC(gui,animButton)) params ["_ctrlButton", "_ctrlBackground"];
_ctrlButton ctrlSetText ((parsingNamespace getVariable "MISSION_ROOT")+"gui\data\tree\add_b_nb.paa");
_ctrlButton ctrlSetTooltip (localize LSTRING(BTTN_CREATE));
_ctrlButton ctrladdEventHandler ["ButtonClick",LINKFUNC(createVehicle)];
_ctrlBackground ctrlSetTextColor [COLOR_SPAWN_BTTN_CREATE_SQF];
// spawn the vehicle
(["create",
    [
        _display,
        GUI_DISP_X + GUI_DISP_WAbs - GUI_DISP_W*26,
        GUI_DISP_Y + GUI_DISP_HAbs - GUI_DISP_H*12,
        GUI_DISP_W*10,
        GUI_DISP_H*10
    ]
] call EFUNC(gui,animButton)) params ["_ctrlButton", "_ctrlBackground"];
_ctrlButton ctrlSetText ((parsingNamespace getVariable "MISSION_ROOT")+"gui\data\tree\dec_b_nb.paa");
_ctrlButton ctrlSetTooltip (localize LSTRING(BTTN_CLEAR));
_ctrlButton ctrladdEventHandler ["ButtonClick",{[] call FUNC(clearPosition)}];
_ctrlBackground ctrlSetTextColor [COLOR_SPAWN_BTTN_CLEAR_SQF];

private _lnb = _display displayCtrl IDC_GUI_VEHICLESPAWN_VEHICLELIST;
_lnb ctrlAddEventHandler ["LBSelChanged",{_this call FUNC(onLnbSelect);}];

private _ctrl = _display displayCtrl IDC_GUI_VEHICLESPAWN_VEHICLELIST_SORTMODS;
_ctrl ctrlAddEventHandler ["ButtonClick",{
    ["switch",_this] call EFUNC(gui,sortButton);
    ["mod"] call FUNC(sortLnb);
    true
}];

private _ctrl = _display displayCtrl IDC_GUI_VEHICLESPAWN_VEHICLELIST_SORTNAMES;
_ctrl ctrlAddEventHandler ["ButtonClick",{
    ["switch",_this] call EFUNC(gui,sortButton);
    ["names"] call FUNC(sortLnb);
    true
}];

GVAR(filterName) = "";
GVAR(filterMod) = "";
GVAR(curVehListFiltered) = nil;

If (isNil QGVAR(FilterHandleID)) then {
    private _ctrlName = _display displayCtrl IDC_GUI_VEHICLESPAWN_VEHICLELIST_NAMES;
    private _ctrlMod = _display displayCtrl IDC_GUI_VEHICLESPAWN_VEHICLELIST_MODS;
    private _ctrlEditName = _display displayCtrl IDC_GUI_VEHICLESPAWN_VEHICLELIST_EDITNAMES;
    private _ctrlEditMod = _display displayCtrl IDC_GUI_VEHICLESPAWN_VEHICLELIST_EDITMODS;

    GVAR(FilterHandleID) = [
        LINKFUNC(filterPFH),
        0.5,
        [
            _display,
            _ctrlName,
            _ctrlEditName,
            _ctrlMod,
            _ctrlEditMod
        ]
    ] call CBA_fnc_addPerFrameHandler;
};



[_display] call FUNC(showList);
["names"] call FUNC(sortLnb);
[] call FUNC(displayProperties);
