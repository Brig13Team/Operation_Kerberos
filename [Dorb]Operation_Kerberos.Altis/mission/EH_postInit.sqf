/*
 *  Author: Dorbedo
 *
 *  Description:
 *      postInit
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

[QGVAR(weaponcache_destroyed),  LINKFUNC(objects_onCacheDestroyed)  ] call CBA_fnc_addEventHandler;

[QGVAR(hostage_rescued),        LINKFUNC(objects_onHostageRescued)  ] call CBA_fnc_addEventHandler;
[QGVAR(hostage_killed),         LINKFUNC(objects_onHostageKilled)   ] call CBA_fnc_addEventHandler;

[QGVAR(commander_captured),        LINKFUNC(objects_onCommanderCaptured)  ] call CBA_fnc_addEventHandler;
[QGVAR(commander_killed),         LINKFUNC(objects_onCommanderKilled)   ] call CBA_fnc_addEventHandler;

[QGVAR(intel_found),            LINKFUNC(objects_onIntelFound)      ] call CBA_fnc_addEventHandler;

[QGVAR(prototype_destroyed),    LINKFUNC(objects_onPrototypeKilled)  ] call CBA_fnc_addEventHandler;
[QGVAR(prototype_rescued),    LINKFUNC(objects_onPrototypeReturned)  ] call CBA_fnc_addEventHandler;
