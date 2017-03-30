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

_this params ["_target"];
GVAR(curSelIndex) = -1;
GVAR(radioSettingsTarget) = _target;

// hide all other things
[] call FUNC(hideAll);

// get the tree and the propertiesList
private _display = uiNamespace getVariable QEGVAR(gui_Echidna,dialog);
private _itemlist = _display displayCtrl IDC_ACRE_MENU_ITEMLIST;
private _radiolist = _display displayCtrl IDC_ACRE_MENU_RADIOLIST;
private _properties = _display displayCtrl IDC_ACRE_MENU_PROPERTIES;
private _back1 = _display displayCtrl IDC_ACRE_MENU_BACK_1;
private _back2 = _display displayCtrl IDC_ACRE_MENU_BACK_2;
private _back3 = _display displayCtrl IDC_ACRE_MENU_BACK_3;
private _properties_combo = _properties controlsGroupCtrl IDC_ACRE_MENU_PROPERTIES_COMBO;
private _watermark = _display displayCtrl IDC_ACRE_MENU_WATERMARK;

lbClear _itemlist;
lbClear _radiolist;

_back1 ctrlSetPosition [
    GUI_ECHIDNA_X + 5.5*GUI_ECHIDNA_W,
    GUI_ECHIDNA_Y + 2.5*GUI_ECHIDNA_H,
    5*GUI_ECHIDNA_W,
    24.5*GUI_ECHIDNA_H
];
_itemlist ctrlSetPosition [
    GUI_ECHIDNA_X + 5.5*GUI_ECHIDNA_W,
    GUI_ECHIDNA_Y + 2.5*GUI_ECHIDNA_H,
    5*GUI_ECHIDNA_W,
    24.5*GUI_ECHIDNA_H
];

_back2 ctrlSetPosition [
    GUI_ECHIDNA_X + 11*GUI_ECHIDNA_W,
    GUI_ECHIDNA_Y + 2.5*GUI_ECHIDNA_H,
    10*GUI_ECHIDNA_W,
    24.5*GUI_ECHIDNA_H
];
_radiolist ctrlSetPosition [
    GUI_ECHIDNA_X + 11.5*GUI_ECHIDNA_W,
    GUI_ECHIDNA_Y + 3*GUI_ECHIDNA_H,
    9*GUI_ECHIDNA_W,
    23.5*GUI_ECHIDNA_H
];

_back3 ctrlSetPosition [
    GUI_ECHIDNA_X + 21.5*GUI_ECHIDNA_W,
    GUI_ECHIDNA_Y + 2.5*GUI_ECHIDNA_H,
    18*GUI_ECHIDNA_W,
    20.5*GUI_ECHIDNA_H
];
_properties ctrlSetPosition [
    GUI_ECHIDNA_X + 22*GUI_ECHIDNA_W,
    GUI_ECHIDNA_Y + 3*GUI_ECHIDNA_H,
    17*GUI_ECHIDNA_W,
    19.5*GUI_ECHIDNA_H
];


_properties_combo ctrlSetPosition [
    GUI_ECHIDNA_W,
    GUI_ECHIDNA_H,
    15.5*GUI_ECHIDNA_W,
    1*GUI_ECHIDNA_H
];

private _pos_x = GUI_ECHIDNA_X + 36.5*GUI_ECHIDNA_W;
private _pos_y = GUI_ECHIDNA_Y + 24*GUI_ECHIDNA_H;
private _pos_w = GUI_ECHIDNA_W*3;
private _pos_h = GUI_ECHIDNA_H*3;
private _picture = ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QUOTE(COMPONENT\data\save.paa));
private _displayName = localize LSTRING(RADIOS_TRANSMITT);
private _ctrl = _display displayCtrl IDC_ACRE_MENU_BTTN6;
_ctrl ctrlAddEventHandler ["ButtonClick",{[GVAR(radioSettingsTarget)] call FUNC(transmitt);true}];
["changepos",[_ctrl,[_pos_x, _pos_y, _pos_w, _pos_h]]] call FUNC(AnimBttn);
_ctrl ctrlSetText _picture;
_ctrl ctrlSetTooltip _displayName;
_ctrl ctrlSetFontHeight (GUI_ECHIDNA_METRO_BTTN_H * 0.1);
_ctrl ctrlSetTextColor [1,1,1,1];

private _pos_x = GUI_ECHIDNA_X + 33*GUI_ECHIDNA_W;
private _picture = ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QUOTE(COMPONENT\data\delete.paa));
private _displayName = localize LSTRING(RADIOS_RESET);
private _ctrl2 = _display displayCtrl IDC_ACRE_MENU_BTTN7;
_ctrl2 ctrlAddEventHandler ["ButtonClick",{[GVAR(radioSettingsTarget)] call FUNC(radiosShow);true}];
["changepos",[_ctrl2,[_pos_x, _pos_y, _pos_w, _pos_h]]] call FUNC(AnimBttn);
_ctrl2 ctrlSetText _picture;
_ctrl2 ctrlSetTooltip _displayName;
_ctrl2 ctrlSetFontHeight (GUI_ECHIDNA_METRO_BTTN_H * 0.1);
_ctrl2 ctrlSetTextColor [1,1,1,1];


_watermark ctrlSetPosition [
    GUI_ECHIDNA_X + GUI_ECHIDNA_W * 10,
    GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 2.5,
    25*GUI_ECHIDNA_W,
    25*GUI_ECHIDNA_H
];
If (_target isEqualType grpNull) then {
    _watermark ctrlSetText ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QUOTE(COMPONENT\data\radio_multi.paa));
}else{
    _watermark ctrlSetText ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QUOTE(COMPONENT\data\radio_single.paa));
};
_watermark ctrlSetTextColor [RAL9022,0.15];
TRACEV_3(_watermark,ctrlText _watermark,ctrlPosition _watermark);
_watermark ctrlCommit 0;
_back1 ctrlCommit 0;
_back2 ctrlCommit 0;
_back3 ctrlCommit 0;
_itemlist ctrlCommit 0;
_radiolist ctrlCommit 0;
_properties ctrlCommit 0;
_properties_combo ctrlCommit 0;
_ctrl ctrlCommit 0;
_ctrl2 ctrlCommit 0;

_itemlist ctrladdEventHandler ["LBDrop",{_this call FUNC(radiosDrop)}];
_radiolist ctrladdEventHandler ["LBDrop",{_this call FUNC(radiosDrop)}];
_radiolist ctrlAddEventHandler ["LBSelChanged",{GVAR(curSelIndex) = _this select 1;[GVAR(curSelIndex)] call FUNC(radiosProperties);}];
_properties_combo ctrlAddEventHandler ["LBSelChanged",{_this call FUNC(radiosPropertiesUpdate);}];


{
    private _radioHash = HASH_GET(GVAR(radioTypeList),_x);
    private _picture = HASH_GET(_radioHash,"picture");
    private _description = HASH_GET(_radioHash,"displayname");
    TRACEV_3(_radioHash,_picture,_description);
    private _index = _itemlist lbAdd "";
    _itemlist lbSetPicture [_index, _picture];
    _itemlist lbSetTooltip [_index, _description];
    _itemlist lbSetData [_index, _x];
} forEach HASH_KEYS(GVAR(radioTypeList));

private _currentRadios = (_target getVariable [QGVAR(radios),[]]) select {!(isNull _x)};
TRACEV_1(_currentRadios);
GVAR(tempRadioList) = [];
{
    private _serialized = HASH_SERIALIZE(_x);
    TRACEV_3(_copy,_x,_serialized);
    private _copy = LHASH_COPY(_x);
    HASH_SET(_copy,"isCopyOf",_x);
    GVAR(tempRadioList) pushBack _copy;
} forEach _currentRadios;

[] call FUNC(radiosList);

[GVAR(curSelIndex)] call FUNC(radiosProperties);
