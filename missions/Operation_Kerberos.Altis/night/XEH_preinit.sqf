#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;

#include "XEH_PREP.sqf"

RECOMPILE_END;

ADDON = true;

GVAR(cache) = false call CBA_fnc_createNamespace;

["CAManBase", "initpost", {
    If(local (_this select 0)) then {
        _this spawn FUNC(addNightItems);
    };
},true,[],true] call CBA_fnc_addClassEventHandler;

[
    QGVAR(randomizeDay),
    "CHECKBOX",
    LSTRING(randomizeDay),
    "Operation Kerberos",
    false,
    2
] call cba_settings_fnc_init;

If (isServer) then {
    [
        {(time > 0) && {!(isNil QGVAR(randomizeDay))}},
        FUNC(setRandomDay)
    ] call CBA_fnc_waitUntilAndExecute;
};
