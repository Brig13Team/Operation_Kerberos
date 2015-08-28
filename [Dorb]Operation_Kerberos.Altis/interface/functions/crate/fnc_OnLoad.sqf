/*
    Author: Dorbedo

    Description:
        called on ui load


*/
#include "script_component.hpp"
SCRIPT(crate_onLoad);
private["_ctrl"];
disableSerialization;

for "_i" from 1 to 20 do {
    _ctrl = (findDisplay 600200 displayCtrl (600210 + _i));
    _ctrl ctrlSetEventHandler ["ButtonClick", FORMAT_1(QUOTE([%1] call FUNC(crate_filter)),_i)];
};

[1] call FUNC(crate_filter);

GVAR(crate_boxes) = [
    ["Box_NATO_Ammo_F"  ,"Box_NATO_WpsLaunch_F" ,"Box_NATO_WpsSpecial_F"    ,"Box_NATO_Support_F"   ,"B_CargoNet_01_ammo_F" ,"B_Slingload_01_Cargo_F"],
    [localize("STR_DORB_CRATE_SIZE1"),localize("STR_DORB_CRATE_SIZE2"),localize("STR_DORB_CRATE_SIZE3"),localize("STR_DORB_CRATE_SIZE4"),localize("STR_DORB_CRATE_SIZE5"),localize("STR_DORB_CRATE_SIZE6")],
    [200                    ,300                        ,500                        ,2000               ,2800                   ,14000]
];

_ctrl = (findDisplay 600200 displayCtrl 600205);
for "_i" from 0 to (count (GVAR(crate_boxes) select 0)) do {
    _ctrl lbAdd ((GVAR(crate_boxes) select 1)select _i);
};
_ctrl lbSetCurSel (GETMVAR(GVAR(crate_current_boxid),0));

["displaymass"] call FUNC(crate_mass);