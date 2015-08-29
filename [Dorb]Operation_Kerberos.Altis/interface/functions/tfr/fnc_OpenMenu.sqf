/*
    Author: Dorbedo

    Description:
    Opens the TFR-Frequenzübersicht dialog


*/
#include "script_component.hpp"
SCRIPT(OpenMenu);
private["_sr","_lr"];
SETMVAR(TFR_UPDATE,false);

createDialog "dorb_tfr";
If (call TFAR_fnc_haveSWRadio) then {
    _sr = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
    ctrlSetText [700205, _sr];
}else{
    ctrlSetText [700205, ""];
};

if (call TFAR_fnc_haveLRRadio) then {
    _lr = (call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getLrFrequency;
    ctrlSetText [700206, _lr];
}else{
    ctrlSetText [700206, ""];
};

["DORB_TFR_onOpenEH", "onEachFrame", {
        [] call FUNC(tfr_onOpen);
     }, []] call BIS_fnc_addStackedEventHandler;