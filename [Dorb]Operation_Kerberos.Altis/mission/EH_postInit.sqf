/*
 *  Author: Dorbedo
 *
 *  Description:
 *      postInit
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

[QGVAR(weaponcache_destroyed),  LINKFUNC(onCacheDestroyed)  ] call CBA_fnc_addEventHandler;

[QGVAR(hostage_rescued),        LINKFUNC(onHostageRescued)  ] call CBA_fnc_addEventHandler;
[QGVAR(hostage_killed),         LINKFUNC(onHostageKilled)   ] call CBA_fnc_addEventHandler;

[QGVAR(intel_found),            LINKFUNC(onIntelFound)      ] call CBA_fnc_addEventHandler;

[QGVAR(prototype_destroyed),    LINKFUNC(onPrototypeKilled)  ] call CBA_fnc_addEventHandler;
[QGVAR(prototype_rescued),    LINKFUNC(onPrototypeReturned)  ] call CBA_fnc_addEventHandler;
