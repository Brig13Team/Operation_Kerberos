#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;

#include "XEH_PREP.sqf"

RECOMPILE_END;

ADDON = true;

GVAR(cache) = false call CBA_fnc_createNamespace;

["CAManBase", "initpost", {
    If(local (_this select 0)) then {
        _this spawn FUNC(addNVG);
    };
},true,[],true] call CBA_fnc_addClassEventHandler;

[
    {time > 0},
    FUNC(setRandomDay)
] call CBA_fnc_waitUntilAndExecute;
