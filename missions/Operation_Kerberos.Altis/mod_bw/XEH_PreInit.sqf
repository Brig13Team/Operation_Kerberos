#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.sqf"

ADDON = true;

If !(hasInterface) exitWith {};

If (isNil "BWA3_MagazineDialogDistance") then {
    BWA3_MagazineDialogDistance = 25;
};

[
    "BWA3_MagazineDialogAllowed",
    "CHECKBOX",
    "STR_BWA3_Comp_Ace_ConfigureMagazinesLoadAllowed",
    localize "STR_BWA3_FactionClassBundeswehrName",
    true,
    1
] call CBA_Settings_fnc_init;

private _action = [
    "BWA3_MagazineDialog",
    localize "STR_BWA3_Comp_Ace_ConfigureAmmoLoad",
    "\A3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa",
    {[_target,[0]] call BWA3_fnc_OpenMagazineDialog},
    {[_target] call BWA3_fnc_canOpenMagazineDialog},
    {},
    []
] call ace_interact_menu_fnc_createAction;

["BWA3_Leopard_base", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
["BWA3_Puma_base", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
