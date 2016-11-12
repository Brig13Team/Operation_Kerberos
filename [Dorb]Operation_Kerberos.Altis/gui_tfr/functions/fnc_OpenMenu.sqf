/*
    Author: Dorbedo

    Description:
    Opens the TFR-Frequenzübersicht dialog


*/
#define INCLUDE_GUI
#include "script_component.hpp"

GVAR(isUpdating) = false;

createDialog QAPP(dialog);
If (call TFAR_fnc_haveSWRadio) then {
    Private _sr = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
    ctrlSetText [IDC_TFR_EDIT_SR, _sr];
}else{
    ctrlSetText [IDC_TFR_EDIT_SR, ""];
};

if (call TFAR_fnc_haveLRRadio) then {
    Private _lr = (call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getLrFrequency;
    ctrlSetText [IDC_TFR_EDIT_LR, _lr];
}else{
    ctrlSetText [IDC_TFR_EDIT_LR, ""];
};

[QGVAR(onOpenEH), "onEachFrame", {
        [] call FUNC(onOpen);
     }, []] call BIS_fnc_addStackedEventHandler;
