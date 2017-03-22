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
private _propertiesList = _dialog displayCtrl IDC_ECHIDNA_SPAWN_VEHICLEPROPERTIES;
private _vehicleName = _dialog displayCtrl IDC_ECHIDNA_SPAWN_VEHICLENAME;

// Events
_vehicleList ctrlAddEventHandler ["LBSelChanged",{_this call FUNC(onSelection)}];
//_vehicleList ctrlAddEventHandler ["LBSelChanged",{systemchat format["_this = %1",_this];}];

private _pos_x = GUI_ECHIDNA_X;
private _pos_y = GUI_ECHIDNA_Y;
private _pos_w = GUI_ECHIDNA_W*20;
private _pos_h = GUI_ECHIDNA_H*2;
_vehicleName ctrlsetPosition [_pos_x,_pos_y,_pos_w,_pos_h];
_vehicleName ctrlSetBackgroundColor [RAL7047,1];
_vehicleName ctrlCommit 0;



_pos_x = GUI_ECHIDNA_X;
_pos_y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H*2.5;
_pos_w = GUI_ECHIDNA_W*20;
_pos_h = GUI_ECHIDNA_H*10;

_propertiesList ctrlsetPosition [_pos_x,_pos_y,_pos_w,_pos_h];
_propertiesList ctrlSetBackgroundColor [RAL7047,1];
_propertiesList ctrlCommit 0;


_pos_x = GUI_ECHIDNA_X + GUI_ECHIDNA_W*20;
_pos_y = GUI_ECHIDNA_Y;
_pos_w = GUI_ECHIDNA_W*20;
_pos_h = GUI_ECHIDNA_H*20;

_vehicleList ctrlsetPosition [_pos_x,_pos_y,_pos_w,_pos_h];
_vehicleList ctrlSetBackgroundColor [RAL7047,1];
_vehicleList ctrlCommit 0;


_pos_x = GUI_ECHIDNA_X + GUI_ECHIDNA_W*22;
_pos_y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H*22;
_pos_w = GUI_ECHIDNA_W*5;
_pos_h = GUI_ECHIDNA_H*5;

//private _picture = ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QEPAAPATH(acre,tree));
private _picture = "\a3\ui_f\data\igui\cfg\simpletasks\types\container_ca.paa";
private _displayName = "Bestellen";
private _ctrl = _dialog displayCtrl IDC_ECHIDNA_SPAWN_VEHICLEBUTTON_1;
_ctrl ctrlAddEventHandler ["ButtonClick",{_this call FUNC(spawnVehicle);true}];
["changepos",[_ctrl,[_pos_x, _pos_y, _pos_w, _pos_h]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (GUI_ECHIDNA_METRO_BTTN_H * 0.1);
_ctrl ctrlSetTextColor [1,1,1,1];


_pos_x = GUI_ECHIDNA_X + GUI_ECHIDNA_W*32;
_pos_y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H*22;
_pos_w = GUI_ECHIDNA_W*5;
_pos_h = GUI_ECHIDNA_H*5;

//private _picture = ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QEPAAPATH(acre,tree));
private _picture = "\a3\ui_f\data\igui\cfg\simpletasks\types\container_ca.paa";
private _displayName = "löschen";
private _ctrl = _dialog displayCtrl IDC_ECHIDNA_SPAWN_VEHICLEBUTTON_2;
_ctrl ctrlAddEventHandler ["ButtonClick",{_this call FUNC(clearPos);true}];
["changepos",[_ctrl,[_pos_x, _pos_y, _pos_w, _pos_h]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (GUI_ECHIDNA_METRO_BTTN_H * 0.1);
_ctrl ctrlSetTextColor [1,1,1,1];

TRACE("OnLoad Finished");

[] call FUNC(showVehicleList);
[] call FUNC(setObject);
[] call FUNC(showProperties);
