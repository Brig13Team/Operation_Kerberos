/*
    Author: Dorbedo

    Description:
       On selection

    Parameter(s):
        1:SCALAR    - Row

*/
#include "script_component.hpp"
SCRIPT(save_select);
#define SAVE_IDD	600240
#define SAVE_LIST 600241
#define SAVE_EDIT 600245
disableSerialization;
private ["_selection","_ctrlList","_ctrledit","_name"];
_selection = _this select 1;
CHECK(!(IS_SCALAR(_selection)))
_ctrledit = findDisplay SAVE_IDD displayCtrl SAVE_EDIT;
_ctrlList = findDisplay SAVE_IDD displayCtrl SAVE_LIST;

_name = _ctrlList lnbText [_selection,0];

_ctrledit ctrlSetText _name;