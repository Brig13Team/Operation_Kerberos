#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;

#include "XEH_PREP.sqf"

RECOMPILE_END;

ADDON = true;

#include "CBA_Settings_initialize.sqf"

ISNIL(active,true);
ISNIL(forcealwaysFirst,false);
ISNIL(forcefoot,true);
ISNIL(forcevehicle,true);
ISNIL(forceair,false);
ISNIL(forceship,true);
