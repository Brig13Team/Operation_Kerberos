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
    private _posX = GUI_ECHIDNA_W;
    private _posW = 10*GUI_ECHIDNA_W;
    private _posH = 1*GUI_ECHIDNA_H;
    private _ctrl = _display ctrlCreate ["RscText", _idc, _ctrlGroup];
    _ctrl ctrlSetPosition [_posX, _posY, _posW, _posH];
    GVAR(tempProperties) pushBack _ctrl;
    _ctrl;
};
_fnc_Checkbox = {
    _this params ["_idc","_posY"];
    private _posX = 10*GUI_ECHIDNA_W;
    private _posW = 1*GUI_ECHIDNA_W;
    private _posH = 1*GUI_ECHIDNA_H;
    private _ctrl = _display ctrlCreate ["RscCheckBox", _idc, _ctrlGroup];
    _ctrl ctrlSetPosition [_posX, _posY, _posW, _posH];
    GVAR(tempProperties) pushBack _ctrl;
    _ctrl;
};
_fnc_Edit = {
    _this params ["_idc","_posY"];
    private _posX = 7.5*GUI_ECHIDNA_W;
    private _posW = 10*GUI_ECHIDNA_W;
    private _posH = 1*GUI_ECHIDNA_H;
    private _ctrl = _display ctrlCreate ["RscEdit", _idc, _ctrlGroup];
    _ctrl ctrlSetPosition [_posX, _posY, _posW, _posH];
    GVAR(tempProperties) pushBack _ctrl;
    _ctrl;
};

private _keys = HASH_GET(GVAR(tempPropertiesRadio),"keysOrdered");

// remove the default name
_keys = ((_keys - ["description"])-["name"])-["label"];


TRACEV_1(_keys);
{
    private _key = _x;
    private _posY = GUI_ECHIDNA_H*3 + _forEachIndex*GUI_ECHIDNA_H;
    private _ctrltext = [-1*(IDC_ACRE_MENU_PROPERTIES_TEXT_1 + _forEachIndex),_posY] call _fnc_Text;

    private _keyname = _key;
    If (isLocalized format[LSTRING(PROPERTYNAME_%1),_key]) then {
        _keyname = localize format[LSTRING(PROPERTYNAME_%1),_key];
    };
    _ctrltext ctrlSetText _keyname;
    _ctrltext ctrlCommit 0;
    //TRACEV_2(_ctrltext,_keyname);

    private _value = HASH_GET(GVAR(tempPropertiesRadio),_key);
    private "_ctrlvalue";
    If (_value isEqualType true) then {
        _ctrlvalue = [(IDC_ACRE_MENU_PROPERTIES_TEXT_1 + _forEachIndex),_posY] call _fnc_Checkbox;
        _ctrlvalue cbSetChecked _value;
        _ctrlvalue ctrlCommit 0;
        TRACEV_3(_key,_value,_posY);
    }else{
        _ctrlvalue = [(IDC_ACRE_MENU_PROPERTIES_TEXT_1 + _forEachIndex),_posY] call _fnc_Edit;
        _ctrlvalue ctrlSetText (str _value);
        _ctrlvalue ctrlCommit 0;
    };




} forEach _keys;


//private _radioTypeHash = HASH_SET(GVAR(radioTypeList),_WeaponName,_radioHash);
//private _channelAmount = HASH_SET(_radioHash,"LastChannelIndex",_channels);









//
