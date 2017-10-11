#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;

#include "XEH_PREP.sqf"

RECOMPILE_END;

ADDON = true;

GVAR(spawns) = [] call CBA_fnc_createNamespace;
GVAR(spawnID) = 1;
GVAR(filter) = "";
