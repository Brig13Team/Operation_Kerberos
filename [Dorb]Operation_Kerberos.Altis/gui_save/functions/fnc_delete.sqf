/*
    Author: Dorbedo

    Description:
    deletes
    
    

*/
#include "script_component.hpp"
#define SAVE_IDD    600240
#define SAVE_LIST 600241
#define SAVE_EDIT 600245
disableSerialization;

private _ctrledit = findDisplay SAVE_IDD displayCtrl SAVE_EDIT;
private _list = profileNamespace getVariable [GVAR(save_list),[]];
private _name = ctrlText _ctrledit;
CHECK(_name isEqualTo "")
private _index = -1;
{
    if ((_x select 0)isEqualTo _name) exitWith {
        _index = _forEachIndex;
    };
}forEach _list;

If (_index >= 0) exitWith {
    _list deleteAt _index;
    profileNamespace setVariable [GVAR(save_list),_list];
};