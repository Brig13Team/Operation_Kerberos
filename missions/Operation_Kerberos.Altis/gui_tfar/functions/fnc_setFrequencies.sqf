/**
 * Author: Dorbedo
 * the unit can set the squad frequencies
 *
 * Arguments:
 * 0: <CONTROL> the button
 *
 * Return Value:
 * None
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_ctrlbttn"];

private _dialog = ctrlParent _ctrlbttn;

private _ctrlcheckbox = _dialog displayCtrl IDC_TFAR_CHECKBOX;

if ((cbChecked _ctrlcheckbox) && {!([ace_player] call FUNC(canSetFrequencies))}) exitWith {
    _ctrlcheckbox cbSetChecked false;
};

private _ctrlEditSR = _dialog displayCtrl IDC_TFAR_EDIT_SR;
private _ctrlEditSR_add = _dialog displayCtrl IDC_TFAR_EDIT_SR_ADD;
private _ctrlEditLR = _dialog displayCtrl IDC_TFAR_EDIT_LR;
private _ctrlEditLR_add = _dialog displayCtrl IDC_TFAR_EDIT_LR_ADD;

private _fnc_isNumber = {
    params["_input", ["_max", 87]];
    private _number = parseNumber _input;
    if (_number < 30) exitWith {false};
    _number = if ((_number mod 1) == 0) then {_number toFixed 0} else {_number toFixed 1};
    ((parsenumber _number) <= _max)
};

private _value = ["", "", "", ""];

_value set [SR_INDEX, (If ([ctrlText _ctrlEditSR, 512] call _fnc_isNumber) then {ctrlText _ctrlEditSR} else {""})];
_value set [SR_ADD_INDEX, (If ([ctrlText _ctrlEditSR_add, 512] call _fnc_isNumber) then {ctrlText _ctrlEditSR_add} else {""})];
_value set [LR_INDEX, (If ([ctrlText _ctrlEditLR, 87] call _fnc_isNumber) then {ctrlText _ctrlEditLR} else {""})];
_value set [LR_ADD_INDEX, (If ([ctrlText _ctrlEditLR_add, 87] call _fnc_isNumber) then {ctrlText _ctrlEditLR_add} else {""})];

TRACEV_2(cbChecked _ctrlcheckbox,_ctrlcheckbox,_value);

if (cbChecked _ctrlcheckbox) then {
    (group ace_player) setVariable [QGVAR(frequencies), _value, true];
    ace_player setVariable [QGVAR(frequencies), _value, true];
    TRACEV_3(_value,group ace_player,ace_player);
} else {
    TRACEV_2(_value,ace_player);
    ace_player setVariable [QGVAR(frequencies_player), _value, true];
};


[_dialog] call FUNC(treeShow);
[_dialog] call FUNC(editShow);
