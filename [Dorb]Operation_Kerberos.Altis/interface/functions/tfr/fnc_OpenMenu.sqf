/*
    Author: Dorbedo

    Description:
    Opens the TFR-Frequenzübersicht dialog


*/
#include "script_component.hpp"
SETMVAR(TFR_UPDATE,false);

createDialog QGVAR(tfr);
If (call TFAR_fnc_haveSWRadio) then {
    Private _sr = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
    ctrlSetText [700205, _sr];
}else{
    ctrlSetText [700205, ""];
};

if (call TFAR_fnc_haveLRRadio) then {
    Private _lr = (call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getLrFrequency;
    ctrlSetText [700206, _lr];
}else{
    ctrlSetText [700206, ""];
};

[QGVAR(tfr_onOpenEH), "onEachFrame", {
        [] call FUNC(tfr_onOpen);
     }, []] call BIS_fnc_addStackedEventHandler;