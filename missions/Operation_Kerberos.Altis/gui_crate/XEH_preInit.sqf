#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;

#include "XEH_PREP.sqf"

RECOMPILE_END;

ADDON = true;

GVAR(spawns) = [] call CBA_fnc_createNamespace;
GVAR(spawnID) = 1;
GVAR(multiplicator) = 1;

GVAR(filterName) = "";

GVAR(curItemList) = [];
GVAR(curItemListID) = 0;
GVAR(curInventory) = HASH_CREATE;

GVAR(preset) = HASH_CREATE;
GVAR(libary) = HASH_CREATE;
