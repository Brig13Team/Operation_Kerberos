/*
    Author: Dorbedo

    Description:
    Updates the List
    
    

*/
#include "script_component.hpp"

#define SAVE_IDD    600240
#define SAVE_LIST 600241
#define SAVE_EDIT 600245

private _ctrlList = findDisplay SAVE_IDD displayCtrl SAVE_LIST;
If (!(ctrlShown _ctrlList)) exitWith {
    [_this select 1] call removePerFrameHandler;
    GVAR(save_isOpened)=false;
};

disableSerialization;

private _list = profileNamespace getVariable [GVAR(save_list),[]];
private _sel = [];
{
    _sel pushBack [[_x select 0],[_forEachIndex],[]];
}forEach _list;
If(_sel isEqualTo []) exitWith {lnbClear SAVE_LIST;};
lnbClear SAVE_LIST;
lnbAddArray [SAVE_LIST,_sel];