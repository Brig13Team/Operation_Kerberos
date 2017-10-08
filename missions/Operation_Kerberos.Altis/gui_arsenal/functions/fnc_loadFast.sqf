/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Loads the template from your profilenamespace
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"

disableSerialization;

private _dialog = uiNamespace getVariable [QEGVAR(gui_main,dialog),(findDisplay IDD_GUI_ARSENAL)];
private _list = _dialog displayCtrl IDC_GUI_ARSENAL_LIST;
TRACEV_2(_dialog,_list);
private _selIndex = lbCurSel _list;
TRACEV_1(_selIndex);
CHECK(_selIndex < 0)
private _name = _list lbText _selIndex;
private _names = (missionNamespace getVariable [QGVAR(fastArsenalList),[[],[]]]) select 0;
private _index = _names find _name;
TRACEV_3(_name,_names,_index);
CHECK(_index < 0)
closeDialog IDD_GUI_ARSENAL;

[player,[profilenamespace,_name]] call bis_fnc_loadinventory;
