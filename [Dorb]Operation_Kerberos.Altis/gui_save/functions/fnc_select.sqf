/*
    Author: Dorbedo

    Description:
       On selection

    Parameter(s):
        1:SCALAR    - Row

*/
#include "script_component.hpp"
#define SAVE_IDD    600240
#define SAVE_LIST 600241
#define SAVE_EDIT 600245
disableSerialization;
private _selection = _this select 1;
CHECK(!(IS_SCALAR(_selection)))
private _ctrledit = findDisplay SAVE_IDD displayCtrl SAVE_EDIT;
private _ctrlList = findDisplay SAVE_IDD displayCtrl SAVE_LIST;

private _name = _ctrlList lnbText [_selection,0];

_ctrledit ctrlSetText _name;