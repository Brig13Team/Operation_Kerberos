/**
 * Author: Dorbedo
 * filters the left list by category
 *
 * Arguments:
 * 0: <CONTROL> the button
 * 1: <SCALAR> the category
 *
 * Return Value:
 * Nothing
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_buttonsCtrl","_id"];
TRACEV_2(_buttonsCtrl,_id);
private _display = ctrlParent _buttonsCtrl;


GVAR(curItemListID) = _id;
private _curList = GVAR(curItemList) select _id;

If !(GVAR(filterName) isEqualTo "") then {
    private _lenght = count GVAR(filterName);
    _curList = _curList select {((toLower (HASH_GET_DEF(GVAR(libary),_x,[ARR_4("","","","")]) select 3)) find GVAR(filterName))>=0};
};

private _ctrl = _display displayCtrl IDC_GUI_CRATE_ITEMLIST;
/*
private _magazines = [];

{
    private _mags =+ (HASH_GET_DEF(GVAR(libary),_x,[ARR_5("","","","",[])]) select 4);
    _magazines append _mags;
} count _curList;

_curList append _magazines;
*/
[_ctrl,_curList] call FUNC(showItemList);
