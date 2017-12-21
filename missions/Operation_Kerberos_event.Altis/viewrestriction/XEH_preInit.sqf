#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;

#include "XEH_PREP.sqf"

RECOMPILE_END;

ADDON = true;

ISNIL(active,true);
ISNIL(forcealwaysFirst,true);
ISNIL(forcefoot,true);
ISNIL(forcevehicle,true);
ISNIL(forceair,true);
ISNIL(forceship,true);
