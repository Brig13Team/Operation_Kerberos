/**
 * Author: Dorbedo
 * update the shown weight
 *
 * Arguments:
 * 0: <DISPLAY> the crate display
 *
 * Return Value:
 * nothing
 *
 */

#include "script_component.hpp"

params ["_display"];

private _control = _display displayCtrl IDC_GUI_CRATE_BOXLIST;
private _containerweight = if ((_control lbValue (lbCurSel _control)) isEqualTo 0) then {
    [(_control lbData (lbCurSel _control))] call FUNC(getContainerSize);
} else {
    [(_control lbData (lbCurSel _control)) call BIS_fnc_objectFromNetId] call FUNC(getContainerSize);
};

private _ctrl = _display displayCtrl IDC_GUI_CRATE_BOXLIST_WEIGHT;
_ctrl ctrlSetText format["%1 kg",_containerweight];

private _ctrl = _display displayCtrl IDC_GUI_CRATE_INVENTORY_WEIGHT;
_ctrl ctrlSetText format["%1 kg",[] call FUNC(getCurWeight)];
