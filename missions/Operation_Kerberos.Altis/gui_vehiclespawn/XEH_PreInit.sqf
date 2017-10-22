#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;
#include "XEH_PREP.hpp"
RECOMPILE_END;

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
ISNIL(option_openPylon,false);
ISNIL(option_current,"info");
