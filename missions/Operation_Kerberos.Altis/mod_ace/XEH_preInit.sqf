#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;

#include "XEH_PREP.sqf"

RECOMPILE_END;

ADDON = true;

[
    QGVAR(revivesettings),
    "LIST",
    LSTRING(revivesettings),
    "Operation Kerberos",
    [[0, 1, 2], [LSTRING(revivesetting_off), LSTRING(revivesetting_simple), LSTRING(revivesetting_advanced)], 2],
    2
] call cba_settings_fnc_init;
