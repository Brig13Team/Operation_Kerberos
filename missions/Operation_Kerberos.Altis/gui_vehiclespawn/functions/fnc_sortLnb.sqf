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
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_column",GVAR(lastSort),[""]]];
GVAR(lastSort) = _column;
private _display = uiNamespace getVariable [QEGVAR(gui_main,dialog),(findDisplay IDD_GUI_VEHICLESPAWN)];
private _lnb = _display displayCtrl IDC_GUI_VEHICLESPAWN_VEHICLELIST;

switch _column do {
    case "mod" : {
        private _order = (_display displayCtrl IDC_GUI_VEHICLESPAWN_VEHICLELIST_SORTMODS) getVariable ["sortorder",true];
        _lnb lnbSort [1,_order];
    };
    default {
        private _order = (_display displayCtrl IDC_GUI_VEHICLESPAWN_VEHICLELIST_SORTNAMES) getVariable ["sortorder",true];
        _lnb lnbSort [0,_order];
    };
};
