#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;

#include "XEH_PREP.sqf"

RECOMPILE_END;

ADDON = true;

[QGVAR(active), "CHECKBOX", LSTRING(active), "Operation Kerberos", true, 1] call CBA_Settings_fnc_init;
