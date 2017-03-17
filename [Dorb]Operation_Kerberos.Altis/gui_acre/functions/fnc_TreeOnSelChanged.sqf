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
#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"

disableSerialization;
_this params ["_tree","_selection"];
TRACEV_1(_selection);
private _data = _tree tvData _selection;

private _display = uiNamespace getVariable QEGVAR(gui_Echidna,dialog);
private _list = _display displayCtrl IDC_ACRE_MENU_PROPERTIESLIST;

lnbClear _list;
private _radioHash = HASH_GET_DEF(GVAR(curTree),_data,locationNull);
TRACEV_2(_data,_radioHash);
If ((_data isEqualTo "")||{isNull _radioHash}) exitWith {
    TRACE("EXIT");
};

private _valuesOrdered = HASH_GET(_radioHash,"keysOrdered");

{
    private _key = _x;
    If (HASH_HASKEY(_radioHash,_key)) then {
        _list lnbAddRow [_key,str (HASH_GET(_radioHash,_key))];
    };
} forEach _valuesOrdered;
