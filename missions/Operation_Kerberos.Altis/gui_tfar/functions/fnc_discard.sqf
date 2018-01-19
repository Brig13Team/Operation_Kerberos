#include "script_component.hpp"

/*
  Name: dorb_gui_tfar_fnc_discard
  Author: Dorbedo
  discards the settings

  Arguments:
    0: Button <CONTROL>

  Return Value:
    None

  Public: Yes
*/

params ["_ctrlbttn"];

private _dialog = ctrlParent _ctrlbttn;

private _ctrlEditSR = _dialog displayCtrl IDC_TFAR_EDIT_SR;
private _ctrlEditSR_add = _dialog displayCtrl IDC_TFAR_EDIT_SR_ADD;
private _ctrlEditLR = _dialog displayCtrl IDC_TFAR_EDIT_LR;
private _ctrlEditLR_add = _dialog displayCtrl IDC_TFAR_EDIT_LR_ADD;

_ctrlEditSR ctrlSetText "";
_ctrlEditSR_add ctrlSetText "";
_ctrlEditLR ctrlSetText "";
_ctrlEditLR_add ctrlSetText "";
