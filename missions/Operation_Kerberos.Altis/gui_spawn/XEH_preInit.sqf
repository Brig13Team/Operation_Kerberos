#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

ADDON = true;

GVAR(spawns) = [] call CBA_fnc_createNamespace;
GVAR(spawnID) = 1;
GVAR(curVehicle) = "";
GVAR(curModPic) = "";
GVAR(filterMod) = "";
GVAR(filterNames) = "";
GVAR(lastSort) = "";

ISNIL(option_spawnEmtpy,false);
ISNIL(option_noSpareParts,false);
ISNIL(option_spawnAsDriver,false);
ISNIL(option_noAmmo,false);
ISNIL(option_current,"info");
