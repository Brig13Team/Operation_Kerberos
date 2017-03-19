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
private _properties_back = _display displayCtrl IDC_ACRE_MENU_PROPERTIES_BACK;

lbClear _itemlist;
lbClear _radiolist;

_itemlist ctrlSetPosition [
    GUI_ECHIDNA_X + 6*GUI_ECHIDNA_W,
    GUI_ECHIDNA_Y + 0.5*GUI_ECHIDNA_H,
    5*GUI_ECHIDNA_W,
    26.5*GUI_ECHIDNA_H
];
_radiolist ctrlSetPosition [
    GUI_ECHIDNA_X + 11.5*GUI_ECHIDNA_W,
    GUI_ECHIDNA_Y + 0.5*GUI_ECHIDNA_H,
    10*GUI_ECHIDNA_W,
    26.5*GUI_ECHIDNA_H
];
_properties ctrlSetPosition [
    GUI_ECHIDNA_X + 22*GUI_ECHIDNA_W,
    GUI_ECHIDNA_Y + 0.5*GUI_ECHIDNA_H,
    17.5*GUI_ECHIDNA_W,
    26.5*GUI_ECHIDNA_H
];
_properties_back ctrlSetPosition [
    GUI_ECHIDNA_X + 22*GUI_ECHIDNA_W,
    GUI_ECHIDNA_Y + 0.5*GUI_ECHIDNA_H,
    17.5*GUI_ECHIDNA_W,
    26.5*GUI_ECHIDNA_H
];

_itemlist ctrlCommit 0;
_radiolist ctrlCommit 0;
_properties ctrlCommit 0;
_properties_back ctrlCommit 0;

_itemlist ctrladdEventHandler ["LBDrop",{_this call FUNC(radiosDrop)}];
_radiolist ctrladdEventHandler ["LBDrop",{_this call FUNC(radiosDrop)}];
_radiolist ctrlAddEventHandler ["LBSelChanged",{GVAR(curSelIndex) = _this select 1;[GVAR(curSelIndex)] call FUNC(radiosProperties);}];

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

GVAR(tempRadioList) = (_target getVariable [QGVAR(radios),[]]) select {!(isNull _x)};

[] call FUNC(radiosList);

[GVAR(curSelIndex)] call FUNC(radiosProperties);
