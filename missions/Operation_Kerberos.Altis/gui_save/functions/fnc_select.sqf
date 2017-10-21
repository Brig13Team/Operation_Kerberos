/*
    Author: Dorbedo

    Description:
       On selection

    Parameter(s):
        1:SCALAR    - Row

*/
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

disableSerialization;
private _selection = _this select 1;
CHECK(!(IS_SCALAR(_selection)))
private _ctrledit = findDisplay IDD_SAVE_DLG displayCtrl IDC_SAVE_EDIT;
private _ctrlList = findDisplay IDD_SAVE_DLG displayCtrl IDC_SAVE_LIST;

private _name = _ctrlList lnbText [_selection,0];

_ctrledit ctrlSetText _name;
