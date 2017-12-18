#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

ADDON = true;

//[QGVAR(delete),FUNC(delete)] call CBA_fnc_addEventHandler;

ISNIL(cfgWeaponCacheLocal,false call CBA_fnc_createNamespace);
ISNIL(cfgVehicleCacheLocal,false call CBA_fnc_createNamespace);
ISNIL(cfgAmmoCacheLocal,false call CBA_fnc_createNamespace);
ISNIL(cfgMagazineCacheLocal,false call CBA_fnc_createNamespace);
