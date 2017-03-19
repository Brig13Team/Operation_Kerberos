/*
 *  Author: [Name of Author(s)]
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
#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"

ISNILS(GVAR(tempProperties),[]);

private _display = uiNamespace getVariable QEGVAR(gui_Echidna,dialog);
private _ctrlGroup = _display displayCtrl IDC_ACRE_MENU_PROPERTIES;
private _combobox = _ctrlGroup controlsGroupCtrl IDC_ACRE_MENU_PROPERTIES_COMBO;
//IDC_ACRE_MENU_PROPERTIES_TEXT_1
{
    ctrlDelete _x;
} forEach GVAR(tempProperties);


If (isNull GVAR(tempPropertiesRadio)) exitWith {
    TRACE("No Radio selected");
};


_fnc_Text = {
    _this params ["_idc","_posY"];
    private _posX = 0;
    private _posW = 10*GUI_ECHIDNA_W;
    private _posH = 10*GUI_ECHIDNA_W;
    private _ctrl = _display ctrlCreate ["RscText", _idc, _ctrlGroup];
    _ctrl ctrlSetPosition [_posX, _posY, _posW, _posH];
    _ctrl;
};
_fnc_Checkbox = {
    _this params ["_idc","_posY"];
    private _posX = 7.5*GUI_ECHIDNA_W;
    private _posW = 10*GUI_ECHIDNA_W;
    private _posH = 10*GUI_ECHIDNA_W;
    private _ctrl = _display ctrlCreate ["RscCheckBox", _idc, _ctrlGroup];
    _ctrl ctrlSetPosition [_posX, _posY, _posW, _posH];
    _ctrl;
};
_fnc_Edit = {
    _this params ["_idc","_posY"];
    private _posX = 7.5*GUI_ECHIDNA_W;
    private _posW = 10*GUI_ECHIDNA_W;
    private _posH = 10*GUI_ECHIDNA_W;
    private _ctrl = _display ctrlCreate ["RscEdit", _idc, _ctrlGroup];
    _ctrl ctrlSetPosition [_posX, _posY, _posW, _posH];
    _ctrl;
};

private _keys = HASH_KEYS(GVAR(tempPropertiesRadio));




//private _radioTypeHash = HASH_SET(GVAR(radioTypeList),_WeaponName,_radioHash);
//private _channelAmount = HASH_SET(_radioHash,"LastChannelIndex",_channels);









//
