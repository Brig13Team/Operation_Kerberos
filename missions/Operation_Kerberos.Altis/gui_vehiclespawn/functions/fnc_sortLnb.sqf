/**
 * Author: Dorbedo
 * sorts the lnb
 *
 * Arguments:
 * 0: <STRING> Column
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

params [["_column",GVAR(lastSort),[""]]];
GVAR(lastSort) = _column;
private _display = uiNamespace getVariable [QEGVAR(gui_main,dialog),(findDisplay IDD_GUI_MAIN)];
private _lnb = _display displayCtrl IDC_GUI_SPAWN_VEHICLELIST;

switch _column do {
    case "mod" : {
        private _order = (_display displayCtrl IDC_GUI_SPAWN_VEHICLELIST_SORTMODS) getVariable ["sortorder",true];
        _lnb lnbSort [1,_order];
    };
    default {
        private _order = (_display displayCtrl IDC_GUI_SPAWN_VEHICLELIST_SORTNAMES) getVariable ["sortorder",true];
        _lnb lnbSort [0,_order];
    };
};
