#define DEBUG_MODE_FULL
#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;

#include "XEH_PREP.sqf"

RECOMPILE_END;

ADDON = true;

GVAR(cache) = false call CBA_fnc_createNamespace;

ISNIL(enabled,true);

["CAManBase", "initpost", {
    if ((GVAR(enabled)) && {local (_this select 0)}) then {
        _this call FUNC(addNightItemsCached);
    };
},true,[],true] call CBA_fnc_addClassEventHandler;

[
    QGVAR(randomizeDay),
    "CHECKBOX",
    LSTRING(randomizeDay),
    "Operation Kerberos",
    true,
    1
] call cba_settings_fnc_init;
[
    QGVAR(propabilityDay),
    "SLIDER",
    LSTRING(propabilityDay),
    "Operation Kerberos",
    [0, 1, 0.5, 2],
    1
] call cba_settings_fnc_init;
[
    QGVAR(enabled),
    "CHECKBOX",
    LSTRING(Nightitems),
    "Operation Kerberos",
    true,
    1
] call cba_settings_fnc_init;
[
    QGVAR(levelNVG),
    "LIST",
    LSTRING(addNVG),
    "Operation Kerberos",
    [[0, 1, 2], [LSTRING(disable), LSTRING(auto), LSTRING(always)], 1],
    1
] call cba_settings_fnc_init;
[
    QGVAR(levelAcc),
    "LIST",
    LSTRING(addAcc),
    "Operation Kerberos",
    [[0, 1, 2, 3], [LSTRING(disable), LSTRING(auto), LSTRING(alwaysFlashlight), LSTRING(alwaysPointer)], 1],
    1
] call cba_settings_fnc_init;

[
    QGVAR(disableTIEquipment),
    "CHECKBOX",
    LSTRING(disableTIEquipment),
    "Operation Kerberos",
    false,
    1,
    {
        params ["_value"];
        TRACEV_2(_value,GVAR(disableTIHandler));
        If (isServer && _value && {isNil QGVAR(disableTIHandler)}) then {
            GVAR(disableTIHandler) = ["AllVehicles", "init", {
                params ["_vehicle"];
                _vehicle disableTIEquipment (missionNamespace getVariable [QGVAR(disableTIEquipment), false]);
            }, true, [], true] call CBA_fnc_addClassEventHandler;
        };
    }
] call cba_settings_fnc_init;

If (isServer) then {
    [
        {(time > 0) && {!(isNil QGVAR(randomizeDay))}},
        FUNC(setRandomDay)
    ] call CBA_fnc_waitUntilAndExecute;
};
