/*
    Author: Dorbedo

    Description:
        Updatedes Pic and Name

    Parameter(s):
        1:SCALAR    - Row

*/
#define INCLUDE_GUI
#include "script_component.hpp"

disableSerialization;

private _selection = _this select 1;

private _ctrlname = findDisplay IDD_SPAWN_DLG displayCtrl IDC_SPAWN_DLG_VEH;
private _ctrlpic = findDisplay IDD_SPAWN_DLG displayCtrl IDC_SPAWN_DLG_PICTURE;
private _ctrlList = findDisplay IDD_SPAWN_DLG displayCtrl IDC_SPAWN_DLG_LIST;

private _name = _ctrlList lnbData [_selection,2];
private _pic = _ctrlList lnbData [_selection,3];

_ctrlname ctrlSetText _name;
_ctrlpic ctrlSetText _pic;
