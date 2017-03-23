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
private _header = _dialog displayCtrl IDC_ECHIDNA_SPAWN_HEADER;
private _spareBack_1 = _dialog displayCtrl IDC_ECHIDNA_SPAWN_SPAREBACK_1;
private _spareBack_2 = _dialog displayCtrl IDC_ECHIDNA_SPAWN_SPAREBACK_2;
private _spareBack_3 = _dialog displayCtrl IDC_ECHIDNA_SPAWN_SPAREBACK_3;
private _spareBack_4 = _dialog displayCtrl IDC_ECHIDNA_SPAWN_SPAREBACK_4;
private _spareBack_5 = _dialog displayCtrl IDC_ECHIDNA_SPAWN_SPAREBACK_5;
private _spareBack_6 = _dialog displayCtrl IDC_ECHIDNA_SPAWN_SPAREBACK_6;

// Events
_vehicleList ctrlAddEventHandler ["LBSelChanged",{_this call FUNC(onSelection)}];

private _pos_x = GUI_ECHIDNA_X;
private _pos_y = GUI_ECHIDNA_Y;
private _pos_w = GUI_ECHIDNA_W*20;
private _pos_h = GUI_ECHIDNA_H*13.5;
_spareBack_1 ctrlsetPosition [_pos_x,_pos_y,_pos_w,_pos_h];
_spareBack_1 ctrlSetBackgroundColor [RAL9010,1];
_spareBack_1 ctrlCommit 0;

_pos_x = GUI_ECHIDNA_X + GUI_ECHIDNA_W*20;
_pos_y = GUI_ECHIDNA_Y;
_pos_w = GUI_ECHIDNA_W*20;
_pos_h = GUI_ECHIDNA_H*27.5;
_spareBack_2 ctrlsetPosition [_pos_x,_pos_y,_pos_w,_pos_h];
_spareBack_2 ctrlSetBackgroundColor [RAL9010,1];
_spareBack_2 ctrlCommit 0;

_pos_x = GUI_ECHIDNA_X;
_pos_y = GUI_ECHIDNA_Y;
_pos_w = GUI_ECHIDNA_W*0.5;
_pos_h = GUI_ECHIDNA_H*27.5;
_spareBack_5 ctrlsetPosition [_pos_x,_pos_y,_pos_w,_pos_h];
_spareBack_5 ctrlSetBackgroundColor [RAL9010,1];
_spareBack_5 ctrlCommit 0;

_pos_x = GUI_ECHIDNA_X;
_pos_y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H*27;
_pos_w = GUI_ECHIDNA_W*40;
_pos_h = GUI_ECHIDNA_H*0.5;
_spareBack_6 ctrlsetPosition [_pos_x,_pos_y,_pos_w,_pos_h];
_spareBack_6 ctrlSetBackgroundColor [RAL9010,1];
_spareBack_6 ctrlCommit 0;




_pos_x = GUI_ECHIDNA_X;
_pos_y = GUI_ECHIDNA_Y;
_pos_w = GUI_ECHIDNA_W*40;
_pos_h = GUI_ECHIDNA_H*2;
_header ctrlsetPosition [_pos_x,_pos_y,_pos_w,_pos_h];
_header ctrlSetBackgroundColor [RAL5015,1];
_header ctrlSetTextColor [RAL9005,1];
_header ctrlSetText localize LSTRING(HEADER);
_header ctrlCommit 0;


_pos_x = GUI_ECHIDNA_X + GUI_ECHIDNA_W*0.5;
_pos_y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H*2.5;
_pos_w = GUI_ECHIDNA_W*19.5;
_pos_h = GUI_ECHIDNA_H*10.5;
_spareBack_3 ctrlsetPosition [_pos_x,_pos_y,_pos_w,_pos_h];
_spareBack_3 ctrlSetBackgroundColor [RAL9018,1];
_spareBack_3 ctrlCommit 0;

_pos_x = GUI_ECHIDNA_X + GUI_ECHIDNA_W;
_pos_y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H*3;
_pos_w = GUI_ECHIDNA_W*18;
_pos_h = GUI_ECHIDNA_H*10;
_propertiesList ctrlsetPosition [_pos_x,_pos_y,_pos_w,_pos_h];
_propertiesList ctrlSetBackgroundColor [RAL7047,1];
_propertiesList ctrlCommit 0;


_pos_x = GUI_ECHIDNA_X + GUI_ECHIDNA_W*20.5;
_pos_y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H*2.5;
_pos_w = GUI_ECHIDNA_W*19;
_pos_h = GUI_ECHIDNA_H*20;
_spareBack_4 ctrlsetPosition [_pos_x,_pos_y,_pos_w,_pos_h];
_spareBack_4 ctrlSetBackgroundColor [RAL9018,1];
_spareBack_4 ctrlCommit 0;

_pos_x = GUI_ECHIDNA_X + GUI_ECHIDNA_W*21;
_pos_y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H*3;
_pos_w = GUI_ECHIDNA_W*18;
_pos_h = GUI_ECHIDNA_H*19;
_vehicleList ctrlsetPosition [_pos_x,_pos_y,_pos_w,_pos_h];
_vehicleList ctrlSetBackgroundColor [RAL7047,1];
_vehicleList ctrlCommit 0;








_pos_x = GUI_ECHIDNA_X + GUI_ECHIDNA_W*31;
_pos_y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H*23.5;
_pos_w = GUI_ECHIDNA_W*3;
_pos_h = GUI_ECHIDNA_H*3;
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


_pos_x = GUI_ECHIDNA_X + GUI_ECHIDNA_W*35;
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
