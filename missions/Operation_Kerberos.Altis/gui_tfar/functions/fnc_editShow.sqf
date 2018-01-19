/**
 * Author: Dorbedo
 * updates the editbox with the current values
 *
 * Arguments:
 * 0: <DIALOG> the dialog
 *
 * Return Value:
 * None
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_dialog"];

private _ctrlcheckbox = _dialog displayCtrl IDC_TFAR_CHECKBOX;

private _value = ["", "", "", ""];

if ((cbChecked _ctrlcheckbox) && {!([ace_player] call FUNC(canSetFrequencies))}) then {
    _ctrlcheckbox cbSetChecked false;
};

if (cbChecked _ctrlcheckbox) then {
    private _value = _curGroup getVariable [QGVAR(frequencies), ["", "", "", ""]];
    if (_value isEqualTo ["", "", "", ""]) then {
        _value = (leader _curGroup) getVariable [QGVAR(frequencies), ["", "", "", ""]];
    };
} else {
    _value = ace_player getVariable [QGVAR(frequencies_player), ["", "", "", ""]];
};




(_dialog displayCtrl IDC_TFAR_EDIT_SR) ctrlSetText (_value select SR_INDEX);
(_dialog displayCtrl IDC_TFAR_EDIT_SR_ADD) ctrlSetText (_value select SR_ADD_INDEX);
(_dialog displayCtrl IDC_TFAR_EDIT_LR) ctrlSetText (_value select LR_INDEX);
(_dialog displayCtrl IDC_TFAR_EDIT_LR_ADD) ctrlSetText (_value select LR_ADD_INDEX);


