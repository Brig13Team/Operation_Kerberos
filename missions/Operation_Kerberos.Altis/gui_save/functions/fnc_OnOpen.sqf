/*
    Author: Dorbedo

    Description:
    Updates the List



*/
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _ctrlList = findDisplay IDD_SAVE_DLG displayCtrl IDC_SAVE_LIST;
If (!(ctrlShown _ctrlList)) exitWith {
    [_this select 1] call removePerFrameHandler;
    GVAR(isOpened)=false;
};

disableSerialization;

private _list = profileNamespace getVariable [QGVAR(list),[]];
private _sel = [];
{
    _sel pushBack [[_x select 0],[_forEachIndex],[]];
}forEach _list;
If(_sel isEqualTo []) exitWith {lnbClear IDC_SAVE_LIST;};
lnbClear IDC_SAVE_LIST;
lnbAddArray [IDC_SAVE_LIST,_sel];
