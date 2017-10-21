/*
 *  Author: Dorbedo
 *
 *  Description:
 *      displays the properties of a radio selected in the treeview
 *
 *  Parameter(s):
 *      0 : CONTROL - the tree
 *      1 : ARRAY - the selection
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"

disableSerialization;
_this params ["_tree","_selection"];
TRACEV_1(_selection);
private _data = _tree tvData _selection;

private _display = uiNamespace getVariable QEGVAR(gui_main,dialog);
private _list = _display displayCtrl IDC_ACRE_MENU_PROPERTIESLIST;

lnbClear _list;
private _radioHash = HASH_GET_DEF(GVAR(curTree),_data,locationNull);
TRACEV_2(_data,_radioHash);
If ((_data isEqualTo "")||{isNull _radioHash}) exitWith {
    TRACE("EXIT");
};

private _valuesOrdered = HASH_GET(_radioHash,"keysOrdered");
_valuesOrdered = ((_valuesOrdered - ["description"]) - ["label"]) - ["name"];

_list lnbAddRow [" "," "];
_list lnbAddRow [" "," "];

If (HASH_GET_DEF(_radioHash,"isPreset",false)) then {
    private _channelName = format["Channel %1",HASH_GET(_radioHash,"channel")];
    If (HASH_HASKEY(_radioHash,"channelName")) then {
        _channelName = HASH_GET(_radioHash,"channelName");
    };
    _list lnbAddRow [localize LSTRING(PRESETCHANNELNAME),_channelName];
    _list lnbAddRow [" "," "];
}else{
    _list lnbAddRow [" "," "];
    _list lnbAddRow [" "," "];
};

{
    private _key = _x;
    If (HASH_HASKEY(_radioHash,_key)) then {
        private _keyname = _key;
        If (isLocalized format[LSTRING(PROPERTYNAME_%1),_key]) then {
            _keyname = localize format[LSTRING(PROPERTYNAME_%1),_key];
        };
        _list lnbAddRow [_keyname,format["%1",HASH_GET(_radioHash,_key)]];
    };
} forEach _valuesOrdered;
