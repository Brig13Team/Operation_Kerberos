/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Shows the radio properties with the edit-fields
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _display = uiNamespace getVariable QEGVAR(gui_main,dialog);
private _ctrlGroup = _display displayCtrl IDC_ACRE_MENU_PROPERTIES;
private _combobox = _ctrlGroup controlsGroupCtrl IDC_ACRE_MENU_PROPERTIES_COMBO;
//IDC_ACRE_MENU_PROPERTIES_TEXT_1
{
    {ctrlDelete _x;} forEach _x;
} forEach GVAR(tempProperties);

If (isNull GVAR(tempPropertiesRadio)) exitWith {
    TRACE("No Radio selected");
};


_fnc_Text = {
    _this params ["_idc","_posY"];
    private _posX = GUI_DISP_W*3;
    private _posW = GUI_DISP_W*18;
    private _posH = GUI_DISP_H*3;
    private _ctrl = _display ctrlCreate ["RscTextNoShadow", _idc, _ctrlGroup];
    _ctrl ctrlSetPosition [_posX, _posY, _posW, _posH];
    _ctrl ctrlSetTextColor [0,0,0,1];
    _ctrl;
};
_fnc_Checkbox = {
    _this params ["_idc","_posY"];
    private _posX = GUI_DISP_W*27;
    private _posW = GUI_DISP_W*3;
    private _posH = GUI_DISP_H*3;
    private _ctrl2 = _display ctrlCreate ["RscText", -1, _ctrlGroup];
    _ctrl2 ctrlSetPosition [_posX + GUI_DISP_W*0.3, _posY + GUI_DISP_H*0.3, _posW * 0.8, _posH * 0.8];
    _ctrl2 ctrlSetText "";
    _ctrl2 ctrlSetBackgroundColor [0,0,0,0.7];
    private _ctrl = _display ctrlCreate ["RscCheckBox", _idc, _ctrlGroup];
    _ctrl ctrlSetPosition [_posX, _posY, _posW, _posH];
    _ctrl ctrlSetTextColor [0,0,0,1];
    [_ctrl,_ctrl2];
};
_fnc_Edit = {
    _this params ["_idc","_posY"];
    private _posX = GUI_DISP_W*27;
    private _posW = GUI_DISP_W*21;
    private _posH = GUI_DISP_H*3;
    TRACEV_4(_posX, _posY, _posW, _posH);
    private _ctrl = _display ctrlCreate ["RscEdit", _idc, _ctrlGroup];
    _ctrl ctrlSetPosition [_posX, _posY, _posW, _posH];
    _ctrl ctrlSetBackgroundColor [0,0,0,0];
    _ctrl ctrlSetTextColor [0,0,0,1];
    _ctrl ctrlSetFont FONT_THIN;
    _ctrl;
};

private _keys = HASH_GET(GVAR(tempPropertiesRadio),"keysOrdered");

// remove the default name
_keys = ((_keys - ["description"])-["name"])-["label"];


TRACEV_1(_keys);
{
    private _key = _x;
    private _posY = GUI_DISP_Y+GUI_DISP_H*30 + _forEachIndex*GUI_DISP_H*3;
    private _ctrltext = [-1*(IDC_ACRE_MENU_PROPERTIES_TEXT_1 + _forEachIndex),_posY] call _fnc_Text;
    private _keyname = _key;
    If (isLocalized format[LSTRING(PROPERTYNAME_%1),_key]) then {
        _keyname = localize format[LSTRING(PROPERTYNAME_%1),_key];
    };
    _ctrltext ctrlSetText _keyname;
    _ctrltext ctrlCommit 0;
    private _ctrlDump = [_ctrltext];
    //TRACEV_2(_ctrltext,_keyname);

    private _value = HASH_GET(GVAR(tempPropertiesRadio),_key);
    private "_ctrlvalue";
    TRACEV_2(_key,_value);
    If (_value isEqualType true) then {
        _ctrlvalue = [(IDC_ACRE_MENU_PROPERTIES_TEXT_1 + _forEachIndex),_posY] call _fnc_Checkbox;
        (_ctrlvalue select 0) cbSetChecked _value;
        (_ctrlvalue select 1) ctrlCommit 0;
        (_ctrlvalue select 0) ctrlCommit 0;
        _ctrlDump append _ctrlvalue;
        TRACEV_3(_key,_value,_posY);
    }else{
        _ctrlvalue = [(IDC_ACRE_MENU_PROPERTIES_TEXT_1 + _forEachIndex),_posY] call _fnc_Edit;
        _ctrlvalue ctrlSetText format["%1",_value];
        _ctrlvalue ctrlCommit 0;
        TRACEV_1(_ctrlvalue);
        _ctrlDump pushBack _ctrlvalue;
    };


    GVAR(tempProperties) pushBack _ctrlDump;

} forEach _keys;
