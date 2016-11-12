/*
    Author: Dorbedo

    Description:
        called on ui load


*/
#include "script_component.hpp"
private "_ctrl";
disableSerialization;

missionNamespace setVariable [QGVAR(crate_multi),1];

(findDisplay 600200) displayAddEventHandler ["KeyDown",QUOTE([ARR_2(_this select 1,true)] call FUNC(keyEvent);)];
(findDisplay 600200) displayAddEventHandler ["KeyUp",QUOTE([ARR_2(_this select 1,false)] call FUNC(keyEvent);)];
for "_i" from 1 to 20 do {
    _ctrl = (findDisplay 600200 displayCtrl (600210 + _i));
    _ctrl ctrlSetEventHandler ["ButtonClick", FORMAT_1(QUOTE([%1] call FUNC(filter)),_i)];
};

[1] call FUNC(filter);

GVAR(crate_boxes) = [
    ["Box_NATO_Ammo_F"  ,"Box_NATO_WpsLaunch_F",  "Box_NATO_Wps_F",   "Box_NATO_WpsSpecial_F"    ,"IG_supplyCrate_F"       ,"B_CargoNet_01_ammo_F"     ,"B_Slingload_01_Cargo_F"],
    [localize(LSTRING(SIZE1)),localize(LSTRING(SIZE2)),localize(LSTRING(SIZE3)),localize(LSTRING(SIZE4)),localize(LSTRING(SIZE5)),localize(LSTRING(SIZE6)),localize(LSTRING(SIZE7))],
    [200                    ,300          ,400               ,500                        ,2000               ,2800                   ,14000]
];

_ctrl = (findDisplay 600200 displayCtrl 600205);
for "_i" from 0 to (count (GVAR(crate_boxes) select 0)) do {
    _ctrl lbAdd ((GVAR(crate_boxes) select 1)select _i);
};
_ctrl lbSetCurSel (GETMVAR(GVAR(current_boxid),0));

["displaymass"] call FUNC(mass);