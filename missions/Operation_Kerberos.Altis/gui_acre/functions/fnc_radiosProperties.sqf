/*
 *  Author: Dorbedo
 *
 *  Description:
 *      shows the properties of a selected radio
 *
 *  Parameter(s):
 *      0 : SCALAR - the index of the radioList
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"

_this params [["_index",-1,[0]]];

private _display = uiNamespace getVariable QEGVAR(gui_main,dialog);
private _ctrlGroup = _display displayCtrl IDC_ACRE_MENU_PROPERTIES;
private _combobox = _ctrlGroup controlsGroupCtrl IDC_ACRE_MENU_PROPERTIES_COMBO;

lnbClear _combobox;

TRACEV_1(_index);

If (_index < 0) exitWith {
    {
        {ctrlDelete _x;} forEach _x;
    } forEach GVAR(tempProperties);
    GVAR(tempProperties) = [];
    GVAR(tempPropertiesRadio) = locationNull;
    [] call FUNC(radiosPropertiesShow);
};



GVAR(tempPropertiesRadio) = GVAR(tempRadioList) select _index;
TRACEV_3(GVAR(tempPropertiesRadio),allVariables GVAR(tempPropertiesRadio),GVAR(tempRadioList));
private _radioType = toUpper(HASH_GET(GVAR(tempPropertiesRadio),"radioType"));
private _radioTypeHash = HASH_GET(GVAR(radioTypeList),_radioType);
private _lastChannelIndex = HASH_GET(_radioTypeHash,"LastChannelIndex");
private _curChannel = 0;
If ([GVAR(tempPropertiesRadio)] call FUNC(isPreset)) then {
    _curChannel = HASH_GET_DEF(GVAR(tempPropertiesRadio),"channel",-1);
};

TRACEV_3(_radioType,_lastChannelIndex,_curChannel);

for "_i" from 0 to _lastChannelIndex do {
    private _channelName = "";
    If ((toUpper _radioType) in ["ACRE_PRC148","ACRE_PRC152","ACRE_PRC117F"]) then {
        private _key = [_radioType,"description"] call acre_api_fnc_mapChannelFieldName;
        _channelName = [_radioType, [_radioType] call acre_api_fnc_getPreset, _i+1,_key] call acre_api_fnc_getPresetChannelField;
    };
    If ((toUpper _radioType) isEqualTo "ACRE_PRC343") then {
        _channelName = format["B%1-C%2",floor(_i/16)+1,_i-floor(_i/16)*16+1];
    };
    private _listName = format["%1: %2",_i + 1,_channelName];
    private _index = _combobox lbAdd _listName;
    _combobox lbSetValue [_index,_i];
};

_combobox lbSetCurSel _curChannel;

[] call FUNC(radiosPropertiesShow);
