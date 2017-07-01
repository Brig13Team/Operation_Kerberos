//#define DEBUG_MODE_FULL
#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;

#include "XEH_PREP.sqf"

RECOMPILE_END;

ADDON = true;

[QGVAR(delete),FUNC(delete)] call CBA_fnc_addEventHandler;
