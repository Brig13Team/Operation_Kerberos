/*
    Author: Dorbedo

    Description:
    Loads



*/
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
disableSerialization;

private _ctrlList = findDisplay IDD_SAVE_DLG displayCtrl IDC_SAVE_LIST;
private _selection = lnbCurSelRow _ctrlList;
If ((isNil "_selection")||{_selection < 0}) exitWith {};

private _index = _ctrlList lnbValue [_selection,0];
private _list = profileNamespace getVariable [QGVAR(list),[]];
GVAR(current) = (_list select _index)select 1;
GVAR(isopened) = false;
closeDialog IDD_SAVE_DLG;
