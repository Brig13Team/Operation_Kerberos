/*
 *  Author: Dorbedo
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


disableSerialization;
_this params ["_dialog"];

private _vehicleList = _dialog displayCtrl IDC_ECHIDNA_SPAWN_VEHICLELIST;

// Events
_vehicleList ctrlAddEventHandler ["LBSelChanged",{_this call FUNC(onSelection)}];

private _pos_x = GUI_ECHIDNA_X + GUI_ECHIDNA_W*31;
private _pos_y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H*23.5;
private _pos_w = GUI_ECHIDNA_W*3;
private _pos_h = GUI_ECHIDNA_H*3;
private _picture = ((parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\dec_w.paa');
private _displayName = localize LSTRING(BTTN_CLEAR);
private _ctrl = _dialog displayCtrl IDC_ECHIDNA_SPAWN_VEHICLEBUTTON_2;
_ctrl ctrlAddEventHandler ["ButtonClick",{_this call FUNC(clearPos);true}];
["changepos",[_ctrl,[_pos_x, _pos_y, _pos_w, _pos_h]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (GUI_ECHIDNA_METRO_BTTN_H * 0.1);
_ctrl ctrlSetTextColor [1,1,1,1];


_pos_x = GUI_ECHIDNA_X + GUI_ECHIDNA_W*35;
private _picture = ((parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\add_w.paa');
private _displayName = localize LSTRING(BTTN_SPAWN);
private _ctrl = _dialog displayCtrl IDC_ECHIDNA_SPAWN_VEHICLEBUTTON_1;
_ctrl ctrlAddEventHandler ["ButtonClick",{_this call FUNC(spawnVehicle);true}];
["changepos",[_ctrl,[_pos_x, _pos_y, _pos_w, _pos_h]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (GUI_ECHIDNA_METRO_BTTN_H * 0.1);
_ctrl ctrlSetTextColor [1,1,1,1];


TRACE("OnLoad Finished");

[] call FUNC(showVehicleList);
If (((lnbsize _vehicleList) select 0)>0) then {
    _vehicleList lnbSetCurSelRow 0;
}else{
    [] call FUNC(setObject);
    [] call FUNC(showProperties);
};
