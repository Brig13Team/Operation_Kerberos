/*
    Author: Dorbedo

    Description:
    Loads
	
	

*/
#include "script_component.hpp"
SCRIPT(ui_save_load);
#define SAVE_IDD	600240
#define SAVE_LIST 600241
disableSerialization;
private ["_index","_ctrlList","_list","_selection"];

_ctrlList = findDisplay SAVE_IDD displayCtrl SAVE_LIST;
_selection = lnbCurSelRow _ctrlList;
If ((isNil "_selection")||{_selection < 0}) exitWith {};

_index = _ctrlList lnbValue [_selection,0];
_list = profileNamespace getVariable [DORB_SAVE_LIST,[]];
DORB_SAVE_CURRENT = (_list select _index)select 1;
DORB_SAVE_ISOPENED = false;
closeDialog SAVE_IDD;
