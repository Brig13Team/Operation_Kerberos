
#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

ADDON = true;

GVAR(SpawnLast) = CBA_missiontime;
GVAR(cleanUpDump) = [];

ISNIL(camouflage,0);

GVAR(armysWhitelist) = getMissionConfigValue["kerberos_armyWhitelist",[]];
GVAR(armysBlacklist) = getMissionConfigValue["kerberos_armyBlacklist",["vanilla"]];
GVAR(armysBlacklist) = GVAR(armysBlacklist) select {!(_x in GVAR(armysWhitelist))};

// HandleDamage
["Land_Radar_Small_F", "HandleDamage", {
    (_this param [2, 1, [1]])*0.3
}, true, [], true] call CBA_fnc_addClassEventHandler;

// initPost
["CAManBase", "initpost", {
    If(local (_this select 0)) then {
        _this spawn FUNC(addNVG);
    };
},true,[],true] call CBA_fnc_addClassEventHandler;

["rhsusf_M1083A1P2_B_M2_d_Medical_fmtv_usarmy", "initPost", {
    _this call EFUNC(mod_ace,addMedicalItems);
},true,[],true] call CBA_fnc_addClassEventHandler;

["rhs_gaz66_ap2_base", "initPost", {
    _this call EFUNC(mod_ace,addMedicalItems);
},true,[],true] call CBA_fnc_addClassEventHandler;

["ACE_bodyBagObject", "initPost", {
    if (local (_this select 0)) then {deleteVehicle (_this select 0);};
},true,[],true] call CBA_fnc_addClassEventHandler;

["B_Slingload_01_Medevac_F", "initPost", {
    _this call EFUNC(mod_ace,addMedicalItems);
},true,[],true] call CBA_fnc_addClassEventHandler;

// init
["CAManBase", "init", {
    If(local (_this select 0)) then {
        _this call FUNC(gear);
    };
}, true, [], true] call CBA_fnc_addClassEventHandler;

// hit
["LandVehicle", "hit", {
    _this call FUNC(onhit);
},true,[],true] call CBA_fnc_addClassEventHandler;
