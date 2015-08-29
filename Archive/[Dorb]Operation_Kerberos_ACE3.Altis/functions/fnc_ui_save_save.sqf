/*
    Author: Dorbedo

    Description:
    Saves
	
	

*/
#include "script_component.hpp"
SCRIPT(ui_save_save);
#define SAVE_IDD	600240
#define SAVE_LIST 600241
#define SAVE_EDIT 600245
disableSerialization;
private ["_index","_ctrledit","_name","_list"];

_ctrledit = findDisplay SAVE_IDD displayCtrl SAVE_EDIT;
_list = profileNamespace getVariable [DORB_SAVE_LIST,[]];
_name = ctrlText _ctrledit;
_name = [_name] call CBA_fnc_trim;
CHECK(_name isEqualTo "");

_index = -1;
{
	if ((_x select 0)isEqualTo _name) exitWith {
		_index = _forEachIndex;
	};
}forEach _list;

If (_index >= 0) exitWith {
	_list set [_index,[_name,DORB_SAVE_CURRENT]];
	profileNamespace setVariable [DORB_SAVE_LIST,_list];
};

_list pushBack [_name,DORB_SAVE_CURRENT];
profileNamespace setVariable [DORB_SAVE_LIST,_list];
