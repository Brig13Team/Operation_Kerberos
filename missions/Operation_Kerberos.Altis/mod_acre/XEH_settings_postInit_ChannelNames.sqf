/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Channel Names
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _channelnamen = [
    "BODEN",
    "OPZ",
    "LOGISTIK",
    "CAS/FDC",
    "TRUPP 1",
    "TRUPP 2",
    "TRUPP 3",
    "TRUPP 4",
    "TRUPP 5",
    "TRUPP 6"
];

["ACRE_PRC148", "default", QGVAR(COOP)] call acre_api_fnc_copyPreset;
["ACRE_PRC152", "default", QGVAR(COOP)] call acre_api_fnc_copyPreset;
["ACRE_PRC117F", "default", QGVAR(COOP)] call acre_api_fnc_copyPreset;

{
    private _name = If (isLocalized _x) then {localize _x}else{format ["%1",_x]};
    ["ACRE_PRC152", QGVAR(COOP), (_forEachIndex + 1), "description",_name] call acre_api_fnc_setPresetChannelField;
    ["ACRE_PRC148", QGVAR(COOP), (_forEachIndex + 1), "label",_name] call acre_api_fnc_setPresetChannelField;
    ["ACRE_PRC117F", QGVAR(COOP), (_forEachIndex + 1), "name",_name] call acre_api_fnc_setPresetChannelField;
} forEach _channelnamen;

["ACRE_PRC152", QGVAR(COOP)] call acre_api_fnc_setPreset;
["ACRE_PRC148", QGVAR(COOP)] call acre_api_fnc_setPreset;
["ACRE_PRC117F", QGVAR(COOP)] call acre_api_fnc_setPreset;
