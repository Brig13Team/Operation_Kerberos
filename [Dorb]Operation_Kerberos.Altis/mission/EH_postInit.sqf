/*
 *  Author: Dorbedo
 *
 *  Description:
 *      postInit
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

[QGVAR(weaponcache_destroyed),  LINKFUNC(obj_onCacheDestroyed)  ] call CBA_fnc_addEventHandler;

[QGVAR(intel_found),            LINKFUNC(obj_onIntelFound)      ] call CBA_fnc_addEventHandler;

[QGVAR(prototype_destroyed),    LINKFUNC(obj_onPrototypeKilled)  ] call CBA_fnc_addEventHandler;
[QGVAR(prototype_returned),    LINKFUNC(obj_onPrototypeReturned)  ] call CBA_fnc_addEventHandler;

[QGVAR(commander_captured), LINKFUNC(obj_onCommanderCaptured) ] call CBA_fnc_addEventHandler;
[QGVAR(commander_killed),   LINKFUNC(obj_onCommanderKilled)   ] call CBA_fnc_addEventHandler;
[QGVAR(hostage_rescued),    LINKFUNC(obj_onHostageRescued)    ] call CBA_fnc_addEventHandler;
[QGVAR(hostage_killed),     LINKFUNC(obj_onHostageKilled)     ] call CBA_fnc_addEventHandler;

/*
 *      Effects
 */

[QGVAR(earthquake),LINKFUNC(obj_effectEarthquake)] call CBA_fnc_addEventHandler;
[QGVAR(sandstorm),LINKFUNC(obj_createSandstorm)] call CBA_fnc_addEventHandler;

[QGVAR(pickUpSuitcase),{
    [LINKFUNC(handleCarry),15,_this] call CBA_fnc_addPerFrameHandler;
}] call CBA_fnc_addEventHandler;
