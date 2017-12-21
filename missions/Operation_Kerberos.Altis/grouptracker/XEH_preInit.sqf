#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;

#include "XEH_PREP.sqf"

RECOMPILE_END;

ADDON = true;

ISNIL(active,true);
ISNIL(Intervall,5);
ISNIL(delayAmount,3);
ISNIL(AiIsVisible,true);

#include "CBA_Settings_initialize.sqf"
